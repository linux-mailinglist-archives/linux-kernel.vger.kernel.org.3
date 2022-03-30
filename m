Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3844EBFC0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 13:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343616AbiC3L3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 07:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiC3L3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:29:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641BB15AAD8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:27:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9CD351F38C;
        Wed, 30 Mar 2022 11:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648639657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SEh9q825X4XJd27vocQTJ0Ah1yjY4ISz2lUFtaIbslU=;
        b=hiwZ/rnvHAmRUVLDkeV0iDDn9/HCy6oQYGW6bL56T6trX/3UQvFHGHqqxoka2uz3zs8/wb
        r/VkjjjMzfK23RBhwMlEeTMfIK5G9jl5HjCp3aZG/XPLMdAn67JiQHUEtykG1MbG6miwNc
        zlLIXqKQeOTzFgoVXbrfWlURUsIiH6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648639657;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SEh9q825X4XJd27vocQTJ0Ah1yjY4ISz2lUFtaIbslU=;
        b=RFrnMZzzPrRfgPVjY76VRPQm6Ut2g6BailUUqf2UDnkBtTaTTv7Da+SS6IBUe/XEfaINgD
        MGotLDXCyBbVx8DQ==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A5927A3B88;
        Wed, 30 Mar 2022 11:27:34 +0000 (UTC)
Date:   Wed, 30 Mar 2022 13:27:33 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        wangborong@cdjrlc.com, Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>, jniethe5@gmail.com,
        psampat@linux.ibm.com, Miroslav Benes <mbenes@suse.cz>,
        hbh25y@gmail.com, mikey@neuling.org,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Helge Deller <deller@gmx.de>, danielhb413@gmail.com,
        haren@linux.ibm.com, Thierry Reding <treding@nvidia.com>,
        ganeshgr@linux.ibm.com, Corentin Labbe <clabbe@baylibre.com>,
        mamatha4@linux.vnet.ibm.com,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        kernel.noureddine@gmail.com, nathanl@linux.ibm.com,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        YueHaibing <yuehaibing@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, guozhengkui@vivo.com,
        kjain@linux.ibm.com, chenjingwen6@huawei.com,
        Nick Piggin <npiggin@gmail.com>, oss@buserror.net,
        rmclure@linux.ibm.com, maddy@linux.ibm.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jakob Koschel <jakobkoschel@gmail.com>, sachinp@linux.ibm.com,
        bigunclemax@gmail.com, ldufour@linux.ibm.com,
        hbathini@linux.ibm.com,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        farosas@linux.ibm.com, Geoff Levand <geoff@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sourabhjain@linux.ibm.com, Julia Lawall <Julia.Lawall@inria.fr>,
        Ritesh Harjani <riteshh@linux.ibm.com>, cgel.zte@gmail.com,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        tobias@waldekranz.com
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.18-1 tag
Message-ID: <20220330112733.GG163591@kunlun.suse.cz>
References: <87zglefhxd.fsf@mpe.ellerman.id.au>
 <CAHk-=whk4jihDM+zkhZPYRyNO0-YA1_-K9_NyC3EDsX+gkxC-w@mail.gmail.com>
 <87wngefnsu.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wngefnsu.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 08:07:13PM +1100, Michael Ellerman wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> > On Fri, Mar 25, 2022 at 3:25 AM Michael Ellerman <mpe@ellerman.id.au> wrote:

> 
> > That said:
> >
> >> There's a series of commits cleaning up function descriptor handling,
> >
> > For some reason I also thought that powerpc had actually moved away
> > from function descriptors, so I'm clearly not keeping up with the
> > times.
> 
> No you're right, we have moved away from them, but not entirely.
> 
> Functions descriptors are still used for 64-bit big endian, but they're
> not used for 64-bit little endian, or 32-bit.

There was a patch to use ABIv2 for ppc64 big endian. I suppose that
would rid usof the gunction descriptors for good.

Somehow the discussion of that change tralied off without any results.

Maybe it's worth resurrecting?

Thanks

Michal
