Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E99494269
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 22:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343587AbiASVQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 16:16:29 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54748 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245473AbiASVQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 16:16:24 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 35BCB1F3BB;
        Wed, 19 Jan 2022 21:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642626983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E5+44++NWyZq9+G1r9fR6b33+MufeYKyFVvCv/FdmB0=;
        b=CYW64vuB6KoGhYFtRbklZ5AWisTHhaHXqXZvlayZrochbcokgu48mwQDBTrdhintajNREA
        YjIHVCfbWu4AXVeXusZEpemXmtwPZNonSLkvGLbClMQPrjlnZJzqKrEN44liOSgpynkqZv
        QQ2J4U7v3YBmfnK8uZMxrMgEPtOzh28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642626983;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E5+44++NWyZq9+G1r9fR6b33+MufeYKyFVvCv/FdmB0=;
        b=xwkopeJYUB1hxKnxhrWy4TLbEvVMAVq0o5LyBQtn2qsjANX7vB9HEUS8QoBcAyG32dqs9H
        lnZpW7aydgIRxVBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 187A713A09;
        Wed, 19 Jan 2022 21:16:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xA6eBad/6GGlHAAAMHmgww
        (envelope-from <bp@suse.de>); Wed, 19 Jan 2022 21:16:23 +0000
Date:   Wed, 19 Jan 2022 22:16:16 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: vmlinux.o: warning: objtool: do_machine_check()+0x5fa: call to
 memset() leaves .noinstr.text section
Message-ID: <Yeh/oEYGyg2+XYSJ@zn.tnic>
References: <202110261614.Bt8EM6Nj-lkp@intel.com>
 <YXe7AnMmiWXk36NC@zn.tnic>
 <20220119102250.7e20b3df@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <YehZsGAqgd3tJyDV@zn.tnic>
 <20220119104017.31e5ecc7@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <20220119111523.71f8e9e3@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <Yeh013gIveIKdFMP@zn.tnic>
 <20220119123714.22b54d4c@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220119123714.22b54d4c@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 12:37:14PM -0800, Jakub Kicinski wrote:
> gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-3)

I have

$ gcc-8 --version
gcc-8 (SUSE Linux) 8.2.1 20180831 [gcc-8-branch revision 264010]

but I can't trigger anything with it either.

So I had a report about a randconfig from the 0day robot guys which
doesn't look like allmodconfig but which triggered some of the issues
you're seeing and I have fixes for that one which we wanna queue after
-rc1.

You could try them to see if they fix your warnings too. First take the
2 here:

https://lore.kernel.org/r/20220113155357.4706-1-bp@alien8.de

and then this one ontop:

https://lore.kernel.org/r/YeWsopFagTZ4W8WA@zn.tnic

Thx.
 
-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
