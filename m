Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206F24943CE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 00:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344178AbiASXRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 18:17:47 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:36756 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240369AbiASXRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 18:17:31 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ED04C2170E;
        Wed, 19 Jan 2022 23:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642634249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uP1TACAgTpMagaF8KuJohAJ2TbdJF9uOAojOAb7wVMA=;
        b=0QXiciCKn3XmFUUCc+8a3IsVvaBXgbHJGr5NSg8S41UTKacA9PKfL01m4rl91kC9RVQMtm
        dwVDFcP8PDpTXqRmkZJ+Wra+boHkmUUeZyTWb6lyJnYmkhRhpmiYZTbwl5YBiLqWm4tREv
        ujsfoEIFnzMia463z+icO0GYu3PQiPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642634249;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uP1TACAgTpMagaF8KuJohAJ2TbdJF9uOAojOAb7wVMA=;
        b=4QPx+mYD5tz2nZHg/ZPvk1v/DRNRsu89DArQAxJ2zUof/U5Ta1pA0BbAVQl00xw1XgPG8Z
        CwsRXLirPo91EdAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1BE713BBC;
        Wed, 19 Jan 2022 23:17:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Oe3SMgmc6GGURwAAMHmgww
        (envelope-from <bp@suse.de>); Wed, 19 Jan 2022 23:17:29 +0000
Date:   Thu, 20 Jan 2022 00:17:23 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: vmlinux.o: warning: objtool: do_machine_check()+0x5fa: call to
 memset() leaves .noinstr.text section
Message-ID: <YeicA7BKdstxbteX@zn.tnic>
References: <202110261614.Bt8EM6Nj-lkp@intel.com>
 <YXe7AnMmiWXk36NC@zn.tnic>
 <20220119102250.7e20b3df@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <YehZsGAqgd3tJyDV@zn.tnic>
 <20220119104017.31e5ecc7@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <20220119111523.71f8e9e3@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <Yeh013gIveIKdFMP@zn.tnic>
 <20220119123714.22b54d4c@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <Yeh/oEYGyg2+XYSJ@zn.tnic>
 <20220119145727.2034a180@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220119145727.2034a180@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just some off-the-top-of-my-head thoughts:

On Wed, Jan 19, 2022 at 02:57:27PM -0800, Jakub Kicinski wrote:
> vmlinux.o: warning: objtool: mce_start()+0x5e: call to __kasan_check_write() leaves .noinstr.text section

Disable KASAN for the whole of MCE, I dunno.

> vmlinux.o: warning: objtool: mce_gather_info()+0x5f: call to v8086_mode.isra.1() leaves .noinstr.text section

v8086_mode() is a oneliner which does "return 0;" on 64-bit. I can't
fathom how your crazy compiler decided not to inline it. Unless there's
instrumentation gunk blowing this function up.

> vmlinux.o: warning: objtool: do_machine_check()+0xa32: call to mce_clear_state() leaves .noinstr.text section

I guess we can inline that - it is simple and has a single call site.
The compiler should have inlined it but for some reason I doesn't want
to.

> vmlinux.o: warning: objtool: mce_severity_amd.constprop.1()+0xd1: call to mce_severity_amd_smca.isra.0() leaves .noinstr.text section

Your funny compiler doesn't inline that one either even if it is called
only once, just like the above.

So, I'd like to reproduce that here and play with it a bit. What iso
can I install in a guest here so that I can get pretty close to your
environment?

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
