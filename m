Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C4249ACBE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376767AbiAYGvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 01:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359494AbiAYGsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 01:48:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98927C09F4A9;
        Mon, 24 Jan 2022 21:10:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34EDB6141C;
        Tue, 25 Jan 2022 05:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C3CC340E0;
        Tue, 25 Jan 2022 05:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643087440;
        bh=BEVe+YavO8Zvh19/8pYvNnZ7t8RCY/gLna1go7/ya14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bCrIjJQS7hpNgbkV+rEqW37A/jDyaOuhYRuE3KqX4NCEcl75D2235fbUzjjg4LN0D
         iZL/m2epkCPYw+JfZB+RiWgRe1kc/RC3Tw2LnUhSCN1hX63Rd43ZLeh9ric/ZL/Rml
         kznwICzXU62GNSs1CeJt91XZKO64DB8HmIGHtvgCh4aTVvxIOhz+jtpmGTCXTOTNOO
         EVoTkSHKMg55xTmaEWVQXpy/kuMIxR1dsUA9J2mlfcDzBX49nVv4uj37x3uaIbaGZB
         9nKV9OAHKRt0YxL9PUGw7470WHrmMo9XBFaZzuMtHLJw2I1FBNqhKeZ+r7imaSk4d8
         IMaLIFZ+84UaQ==
Date:   Mon, 24 Jan 2022 21:10:38 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com, colyli@suse.de, arnd@arndb.de
Subject: Re: [RFC 3/7] lib: add rocksoft model crc64
Message-ID: <Ye+GTkrZ5YMe5qGt@sol.localdomain>
References: <20220124160107.1683901-1-kbusch@kernel.org>
 <20220124160107.1683901-4-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124160107.1683901-4-kbusch@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 08:01:03AM -0800, Keith Busch wrote:
> Since this model reflects inputs and outputs, a helper table and
> function are added to reverse bits of 8 and 64 bit values.

That's a silly way to do a bit-reflected CRC.  The proper way to do it is to
reflect the bytes too, so that the bits and bytes are ordered consistently, so
explicitly reflecting the bits isn't needed.  Most CRC-32's are bit-reflected,
and they are usually implemented this way.  E.g., see crc32_le() in lib/crc32.c.

Here's a Python script that shows that the Rocksoft CRC-64 can be computed
without explicitly reversing the bits.  It passes the tests from your patch 4:


COEFFS = [63, 61, 59, 58, 56, 55, 52, 49, 48, 47, 46, 44, 41, 37, 36, 34, 32,
          31, 28, 26, 23, 22, 19, 16, 13, 12, 10, 9, 6, 4, 3, 0]
POLY = sum(1 << (63 - coeff) for coeff in COEFFS)

# Generate the table.
table = [0] * 256
for i in range(256):
    crc = 0
    byte = i
    for j in range(8):
        if ((crc ^ (byte >> j)) & 1) == 1:
            crc = (crc >> 1) ^ POLY
        else:
            crc = crc >> 1
    table[i] = crc

# Compute the CRC-64 one byte at a time using the table.
def crc64_rocksoft(data):
    crc = 0xffffffffffffffff
    for byte in data:
        crc = (crc >> 8) ^ table[(crc & 0xff) ^ byte]
    return crc ^ 0xffffffffffffffff

# Tests
assert crc64_rocksoft(bytearray([0] * 4096)) == 0x6482D367EB22B64E
assert crc64_rocksoft(bytearray([255] * 4096)) == 0xC0DDBA7302ECA3AC
assert crc64_rocksoft(bytearray([i % 256 for i in range(4096)])) == 0x3E729F5F6750449C
assert crc64_rocksoft(bytearray([(255-i) % 256 for i in range(4096)])) == 0x9A2DF64B8E9E517E

# Print the table.
print(f'#define CRC64_ROCKSOFT_POLY 0x{POLY:016x}ULL')
print('')
print('static const u64 crc64_rocksoft_tab[] = {')
for i in range(0, 256, 2):
    print('\t', end='')
    for j in range(i, i + 2):
        print(f'0x{table[j]:016x}ULL,', end='')
        if j != 1:
            print(' ', end='')
    print('')
print('};')
