Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC235502BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 16:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349545AbiDOO3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 10:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243424AbiDOO3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:29:03 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4912662C8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 07:26:35 -0700 (PDT)
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8AA9B3F1D8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650032793;
        bh=e3RLpJj2erPmdXlxjGIy8hlcTxe8lmbZHUTfXz0Qd8w=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=vWgmxyLmYq6DDAjwoujgT7Vy7BbAII6rCtDXFhGmRH3WFcQ7Y1tQ9EM2w2VjtMzvf
         2ybUrr2e2BCqO6AgaCc77LwU9mALspMVxYXkc9MBVf1sbnWxRVRNkTyTlLd8U5b8P7
         bkWTX33r1cO1ErHliDMUegNjqiASTX5nzLIj29Iqi21FCvh05guaYKIOR0rI2493gy
         7Jk1BYcxt+FnCCyDMcb8wbk9M2WvsegH9PxyS+m4CtSKOxe0KqmM+vAR0LvVZOI4D/
         r/g6vIWdu57gzkhUzai8Pcgg5Ffx72oCUi2I6Is2tcqBk7PUvjBsxMpopMvdRSIhkP
         DHxdaYSN5Wp4w==
Received: by mail-oo1-f72.google.com with SMTP id x63-20020a4a4142000000b003369bebf175so1490437ooa.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 07:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e3RLpJj2erPmdXlxjGIy8hlcTxe8lmbZHUTfXz0Qd8w=;
        b=56uqN47O/2Wiop8dvTYba3scVd35ShMyMSX3hl4GtKL1b7S+G8cvMhwqjs08yPFKzW
         4Mooz3fpFH/heNLPFNQV4sT5vBMGQ4Q8b/UzzWIk8OJ0dnZu5p4slQovjWk8rcCsHzGN
         51YWSnfNj7gVlSe6+fkLNMhltMkjtKZYdclFfOzF0sgdfLQI2uarTXkqHZ1PTzKwkKwj
         7VD0rYiI8rABkVegfx1Wq44X/ibNyuizy8HJXY1jur3cVZfhpjF15h+SjSXYTPtV7uPE
         +pY3f2HeSYFLxhqbDr5VGqTpr3wT1zKoj+OEEDpwecvHCMRQ/3uLiWLR9CeD9zS26HAb
         wdew==
X-Gm-Message-State: AOAM533EssV5e8ueKaJyUX0OQR7QDqpEmec2JGC002ucMidafr+dCeB/
        I9owMB8IiiycSKUr/5/ZezhrZEw21e49wY8vr4d48CZhkCg/MQd8+GWoRMTJUYJXq8ldLoJAj7h
        SKKOziW3f+FF3kQtJBfxXF5xZMBYG5hI9hFkJX3OYusiQnxDfYQ3cNg3HQg==
X-Received: by 2002:a05:6808:124c:b0:2f9:c7cf:146 with SMTP id o12-20020a056808124c00b002f9c7cf0146mr1655286oiv.54.1650032791025;
        Fri, 15 Apr 2022 07:26:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLRc42uKkOW9jRr8zGyO4TRYeWat9aikXqDx0Q0Pk1DISGwEXTIxuzl6vUfgU29zi70pptiplIF+LuV40c7wQ=
X-Received: by 2002:a05:6808:124c:b0:2f9:c7cf:146 with SMTP id
 o12-20020a056808124c00b002f9c7cf0146mr1655264oiv.54.1650032790778; Fri, 15
 Apr 2022 07:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAAd53p4r1v_sN=8kv_fOx_VEb3k=4rU9iw52LfmEHO1crnms=g@mail.gmail.com>
 <20220414164134.GA751756@bhelgaas>
In-Reply-To: <20220414164134.GA751756@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 15 Apr 2022 22:26:19 +0800
Message-ID: <CAAd53p6DX2C7KVRV=uu_mmPTTjE7=RsXfNPxjbOBLRbf-pXi5A@mail.gmail.com>
Subject: Re: [PATCH V1] PCI/ASPM: Save/restore L1SS Capability for suspend/resume
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        "Kenneth R. Crudup" <kenny@panix.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, hkallweit1@gmail.com,
        wangxiongfeng2@huawei.com, mika.westerberg@linux.intel.com,
        chris.packham@alliedtelesis.co.nz, yangyicong@hisilicon.com,
        treding@nvidia.com, jonathanh@nvidia.com, abhsahu@nvidia.com,
        sagupta@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Ricky Wu <ricky_wu@realtek.com>,
        Rajat Jain <rajatja@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Victor Ding <victording@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 12:41 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Apr 13, 2022 at 08:19:26AM +0800, Kai-Heng Feng wrote:
> > On Wed, Apr 13, 2022 at 6:50 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > ...
>
> > >   - For L1 PM Substates configuration, sec 5.5.4 says that both ports
> > >     must be configured while ASPM L1 is disabled, but I don't think we
> > >     currently guarantee this: we restore all the upstream component
> > >     state first, and we don't know the ASPM state of the downstream
> > >     one.  Maybe we need to:
> > >
> > >       * When restoring upstream component,
> > >           + disable its ASPM
> > >
> > >       * When restoring downstream component,
> > >           + disable its ASPM
> > >           + restore upstream component's LTR, L1SS
> > >           + restore downstream component's LTR, L1SS
> > >           + restore upstream component's ASPM
> > >           + restore downstream component's ASPM
> >
> > Right now L1SS isn't reprogrammed after S3, and that causes WD NVMe
> > starts to spew lots of AER errors.
>
> Right now we don't fully restore L1SS-related state after S3, so maybe
> there's some inconsistency that leads to the AER errors.
>
> Could you collect the "lspci -vv" state before and after S3 so we can
> compare them?
>
> > So yes please restore L1SS upon resume. Meanwhile I am asking vendor
> > _why_ restoring L1SS is crucial for it to work.
> >
> > I also wonder what's the purpose of pcie_aspm_pm_state_change()? Can't
> > we just restore ASPM bits like other configs?
>
> Good question.  What's the context?  This is in the
> pci_raw_set_power_state() path, not the pci_restore_state() path, so
> seems like a separate discussion.

Because this patch alone doesn't restore T_PwrOn and LTR1.2_Threshold.

So I forced the pcie_aspm_pm_state_change() calling path to eventually
call aspm_calc_l1ss_info() which solved the problem for me.

Let me investigate a bit further.

Kai-Heng

>
> Bjorn
