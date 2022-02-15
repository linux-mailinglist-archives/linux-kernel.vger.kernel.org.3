Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7BC4B7905
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244166AbiBOUrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:47:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237521AbiBOUro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:47:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD685FBF;
        Tue, 15 Feb 2022 12:47:33 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C8A071F37B;
        Tue, 15 Feb 2022 20:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644958051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FlfsyHCAs0rdIX//YatnIpiwimkoa18Lt0kLGHb4O7E=;
        b=OARPnhmPW7qBVTlDY6oU/h/RXco0jkDnGZJwh7Qzb65K1gtp0B2Y2N4GnqEQYZj8Pp0sbN
        AdWt2MzVAqrrwO2oUaXSeVgeRYwF7OkNORYRlp22XWtm7O3mKr6KnB4guXqUfnnJUu94GW
        vPY36B6Jf3wxAgqmLYS26q1rp+O/vzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644958051;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FlfsyHCAs0rdIX//YatnIpiwimkoa18Lt0kLGHb4O7E=;
        b=J6eCNMY6o4jcfwtx/YyCr2tGzh12PjjFMaNcT6a8Lmgs3C8jzDsc69GNV/ct8k1n8uhUHY
        wg2yBhsE/yKZ73Dw==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 83940A3B83;
        Tue, 15 Feb 2022 20:47:31 +0000 (UTC)
Date:   Tue, 15 Feb 2022 21:47:30 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Philipp Rudo <prudo@redhat.com>, Baoquan He <bhe@redhat.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Dave Young <dyoung@redhat.com>,
        Kairui Song <kasong@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-modules@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        stable@kernel.org, Eric Snowberg <eric.snowberg@oracle.com>
Subject: Re: [PATCH 4/4] module, KEYS: Make use of platform keyring for
 signature verification
Message-ID: <20220215204730.GQ3113@kunlun.suse.cz>
References: <cover.1644953683.git.msuchanek@suse.de>
 <840433bc93a58d6dfc4d96c34c0c3b158a0e669d.1644953683.git.msuchanek@suse.de>
 <3e39412657a4b0839bcf38544d591959e89877b8.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e39412657a4b0839bcf38544d591959e89877b8.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Feb 15, 2022 at 03:08:18PM -0500, Mimi Zohar wrote:
> [Cc'ing Eric Snowberg]
> 
> Hi Michal,
> 
> On Tue, 2022-02-15 at 20:39 +0100, Michal Suchanek wrote:
> > Commit 278311e417be ("kexec, KEYS: Make use of platform keyring for signature verify")
> > adds support for use of platform keyring in kexec verification but
> > support for modules is missing.
> > 
> > Add support for verification of modules with keys from platform keyring
> > as well.
> 
> Permission for loading the pre-OS keys onto the "platform" keyring and
> using them is limited to verifying the kexec kernel image, nothing
> else.

Why is the platform keyring limited to kexec, and nothing else?

It should either be used for everything or for nothing. You have the
option to compile it in and then it should be used, and the option to
not compile it in and then it cannot be used.

There are two basic use cases:

(1) there is a vendor key which is very hard to use so you sign
something small and simple like shim with the vendor key, and sign your
kernel and modules with your own key that's typically enrolled with shim
MOK, and built into the kernel.

(2) you import your key into the firmware, and possibly disable the
vendor key. You can load the kernel directly without shim, and then your
signing key is typically in the platform keyring and built into the
kernel.

In neither case do I see any reason to use some keyrings for kexec and
other keyrings for modules.

Thanks

Michal
