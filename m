Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2D7563C67
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 00:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiGAWeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 18:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiGAWeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 18:34:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B223286FA;
        Fri,  1 Jul 2022 15:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D9z9tmqYELHEeBnZPEjhk2lDEhwvDuDmGseECDJuC+w=; b=jKmVp/SnTAhrZOwADR+kIIBfcT
        U5sXKT5j04NtYY4c+qwsFhybsS7kBL3dAxklEec2Kb2oVPKEzx4TZmcT5FWcwQDsp97nfm9qrLHu2
        oRvOqsu4mub/IeIophYcQTnovPxx4DSngQmCflivwRu38Dd/mkLtoUaFtJyh6LhpRYPB4b16lgVgd
        S5qtQ1s4tOdbnvZ8Kqe/SBTxu/HaHym6l/GTDMikKWXmfn5q2C3glMt5YJBNYLc7l/vkmZy3Kji2L
        GNfYP1qBk30F4QuAMVnoopn97ohGzcxYttymzTkhlki29TxirwAaDEBCeZduFr45AaMYSxSgYg4qa
        93ROLY9w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o7PDG-007Eps-OE; Fri, 01 Jul 2022 22:34:10 +0000
Date:   Fri, 1 Jul 2022 15:34:10 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, christophe.leroy@csgroup.eu,
        cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 09/14] module: Move kallsyms support into a separate
 file
Message-ID: <Yr92YtG12f+II+ea@bombadil.infradead.org>
References: <20220310102413.3438665-1-atomlin@redhat.com>
 <20220310102413.3438665-10-atomlin@redhat.com>
 <20220628000526.11c57cd8@gandalf.local.home>
 <20220628081906.jln2ombfej5473xi@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628081906.jln2ombfej5473xi@ava.usersys.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 09:19:06AM +0100, Aaron Tomlin wrote:
> On Tue 2022-06-28 00:05 -0400, Steven Rostedt wrote:
> > On Thu, 10 Mar 2022 10:24:08 +0000
> > Aaron Tomlin <atomlin@redhat.com> wrote:
> > 
> > > No functional change.
> > > 
> > 
> > And this too has a functional change as well.
> > 
> > Reported-by: Chuck Lever III <chuck.lever@oracle.com>
> > Link: https://lore.kernel.org/all/355D2478-33D3-4046-8422-E512F42C51BC@oracle.com/
> > 
> > 
> > Before this patch:
> > 
> >  # grep -a '^[0-9a-f]* [^a-zA-Z]' /proc/kallsyms
> > 
> > Nothing.
> > 
> > After this patch:
> > 
> >  # grep -a '^[0-9a-f]* [^a-zA-Z]' /proc/kallsyms
> > ffffffffc09df024 ^@ _note_9     [ebtables]
> > ffffffffc09df03c ^@ _note_8     [ebtables]
> > ffffffffc0e25024 ^@ _note_9     [bridge]
> > ffffffffc0e2503c ^@ _note_8     [bridge]
> > ffffffffc0e01000 ^@ br_switchdev_event  [bridge]
> > ffffffffc0e39548 ^@ __warned.10 [bridge]
> > ffffffffc09bd024 ^@ _note_9     [stp]
> > ffffffffc09bd03c ^@ _note_8     [stp]
> > ffffffffc0849024 ^@ _note_9     [vmw_vmci]
> > ffffffffc084903c ^@ _note_8     [vmw_vmci]
> > ffffffffc0849454 ^@ __kstrtab_vmci_context_get_priv_flags       [vmw_vmci]
> > ffffffffc0849470 ^@ __kstrtabns_vmci_context_get_priv_flags     [vmw_vmci]
> > ffffffffc0849054 ^@ __ksymtab_vmci_context_get_priv_flags       [vmw_vmci]
> > ffffffffc081d024 ^@ _note_9     [nf_reject_ipv6]
> > ffffffffc081d03c ^@ _note_8     [nf_reject_ipv6]
> > ffffffffc081d0a8 ^@ __kstrtab_nf_reject_skb_v6_tcp_reset        [nf_reject_ipv6]
> > ffffffffc081d0c3 ^@ __kstrtabns_nf_reject_skb_v6_tcp_reset      [nf_reject_ipv6]
> > ffffffffc081d078 ^@ __ksymtab_nf_reject_skb_v6_tcp_reset        [nf_reject_ipv6]
> > ffffffffc081d0c4 ^@ __kstrtab_nf_reject_skb_v6_unreach  [nf_reject_ipv6]
> > 
> > The kallsyms get corrupted output, and this breaks trace-cmd.
> 
> Hi Steve,
> 
> I will look into this straight away.

Poke, did you get to implement this yet?

  Luis
