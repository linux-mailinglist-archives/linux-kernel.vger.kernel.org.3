Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28D04A4692
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 13:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350277AbiAaMGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 07:06:52 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35044 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349744AbiAaMGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 07:06:51 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9229D1F380;
        Mon, 31 Jan 2022 12:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643630810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=au++jgF3hU5FpkHd303MYYokLkB+gG3lUSiPbhg7U68=;
        b=L4yFauK8DPlTNaX8IHOVwsd6E3sD7KLLrzgnivMK+98d3UqJwEIEgGguAmkkS8+wbafwYo
        xfJ792Yfrnh7VSnD2FvVW2w1nsaz+Z93lrVRBRctz97ddUE8WsYF57DvckwL3RXSABghcs
        IlW/IIc6qaRzBWjj5ThoS9GoQPqLuiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643630810;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=au++jgF3hU5FpkHd303MYYokLkB+gG3lUSiPbhg7U68=;
        b=lwxUKuxzi2DzF7sbefT2HnQtscVPok8yLPfTYP8kxZKgyXS7L1Klw4MTC9E64rzSrln/9Q
        EUVC4QPardoIbpCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B55413C40;
        Mon, 31 Jan 2022 12:06:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tauBHNrQ92EkZAAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 31 Jan 2022 12:06:50 +0000
Date:   Mon, 31 Jan 2022 13:06:45 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: vmlinux.o: warning: objtool: do_machine_check()+0x5fa: call to
 memset() leaves .noinstr.text section
Message-ID: <YffQ1XJ+9YAVa163@zn.tnic>
References: <20220119102250.7e20b3df@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <YehZsGAqgd3tJyDV@zn.tnic>
 <20220119104017.31e5ecc7@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <20220119111523.71f8e9e3@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <Yeh013gIveIKdFMP@zn.tnic>
 <20220119123714.22b54d4c@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <Yeh/oEYGyg2+XYSJ@zn.tnic>
 <20220119145727.2034a180@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <YeicA7BKdstxbteX@zn.tnic>
 <20220119153218.02ee6789@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220119153218.02ee6789@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 03:32:18PM -0800, Jakub Kicinski wrote:
> On Thu, 20 Jan 2022 00:17:23 +0100 Borislav Petkov wrote:
> > So, I'd like to reproduce that here and play with it a bit. What iso
> > can I install in a guest here so that I can get pretty close to your
> > environment?
> 
> It's CentOS Stream 8. It may have some extra backports done by my $corp
> but I don't think the compiler is backported.

Ok, while trying to boot an externally supplied kernel with qemu -kernel
and with a guest install of centos8, I managed to trigger the issues on
the test box.

I've pushed a branch here for you to test:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=rc1%2bmce-noinstr

Lemme know how that goes.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
