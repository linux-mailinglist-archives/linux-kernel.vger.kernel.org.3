Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F1F49B7DB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582282AbiAYPmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:42:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59578 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385965AbiAYPkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:40:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9892FB81814;
        Tue, 25 Jan 2022 15:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE3FC340E0;
        Tue, 25 Jan 2022 15:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643125193;
        bh=uNyjZOcU2IAryn5EV8J/+fRYJaBYG5sJZ9cOcNYSXKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C1r3iAOnInePO7W2vzlG/JCu7lpHJTZx4DYsvuA7G/wWHlrehhV+RLui7rytxsvKO
         5469WoSZY7zhTDHqhHTWbF5x6iJsdWNZxJNwCNfmchq7orWCL0dn53zMGOqmP6YIHs
         7EsnU1SHCe5Kg1vmj4Sl1BW3cha5XoK4AW8/kFOSJEAcVdundY/CLjUw1g1ues6qqg
         7yKk1nRlhXRJnxTVLMKfbj2BCfZHB+3sRUhriuY1rmTSJEmspj7qRqaai5lTr3Zkis
         /OLzRAPmaeqonHrRZ9p+F7HuS35/vfC0K337VHjKa+TIyZ2YqTzounznnT76g5ODss
         KbX0i1RJ4mhjw==
Date:   Tue, 25 Jan 2022 07:39:50 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com, colyli@suse.de, arnd@arndb.de
Subject: Re: [RFC 3/7] lib: add rocksoft model crc64
Message-ID: <20220125153950.GB1683949@dhcp-10-100-145-180.wdc.com>
References: <20220124160107.1683901-1-kbusch@kernel.org>
 <20220124160107.1683901-4-kbusch@kernel.org>
 <Ye+GTkrZ5YMe5qGt@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye+GTkrZ5YMe5qGt@sol.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 09:10:38PM -0800, Eric Biggers wrote:
> On Mon, Jan 24, 2022 at 08:01:03AM -0800, Keith Busch wrote:
> > Since this model reflects inputs and outputs, a helper table and
> > function are added to reverse bits of 8 and 64 bit values.
> 
> That's a silly way to do a bit-reflected CRC.  The proper way to do it is to
> reflect the bytes too, so that the bits and bytes are ordered consistently, so
> explicitly reflecting the bits isn't needed.  Most CRC-32's are bit-reflected,
> and they are usually implemented this way.  E.g., see crc32_le() in lib/crc32.c.
> 
> Here's a Python script that shows that the Rocksoft CRC-64 can be computed
> without explicitly reversing the bits.  It passes the tests from your patch 4:

Thanks for the tip! I'll use that for the next version.
