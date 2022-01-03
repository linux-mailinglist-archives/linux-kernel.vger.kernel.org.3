Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627534834D7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbiACQjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:39:01 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43351 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229920AbiACQjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:39:00 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 203GcsAu002472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Jan 2022 11:38:54 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2C56815C00E1; Mon,  3 Jan 2022 11:38:54 -0500 (EST)
Date:   Mon, 3 Jan 2022 11:38:54 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Jann Horn <jannh@google.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random: Don't reset crng_init_cnt on urandom_read()
Message-ID: <YdMmnnAkLpk81mYN@mit.edu>
References: <20220103155931.411722-1-jannh@google.com>
 <CAHmME9otnT=XeMPGYW5H8TOu9aLxxKi6_gT-Fnvh5Jy+WM-HGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9otnT=XeMPGYW5H8TOu9aLxxKi6_gT-Fnvh5Jy+WM-HGA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 05:03:57PM +0100, Jason A. Donenfeld wrote:
> On Mon, Jan 3, 2022 at 4:59 PM Jann Horn <jannh@google.com> wrote:
> > This code was inconsistent, and it probably made things worse - just get
> > rid of it.
> 
> Rather than adding crng_init_cnt=0 if crng_init<1 to extract_crng_user
> and get_random_bytes, getting rid of it like this seems probably okay
> and makes the model simpler. I'll apply this. Thank you.

Ack.  It does mean that we're making a choice that an attacker who is
carrying out a incremental state tracking attack on the CRNG will make
/dev/urandom (and getrandom) to make the crng emit "less secure" in
the period when crng_init is > 0 and < 2.  On the other hand, this
allows us to get to the state of crng_init=2 faster, where as before,
the attacker could delay getting us to the state crng_init=1 forever,
where reads from /dev/urandom would be hence be insecure forever (and
getrandom() would block forever).


						- Ted
