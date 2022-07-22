Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F5D57DB49
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbiGVHbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiGVHbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:31:44 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782E29822A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:31:42 -0700 (PDT)
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D05B03F0D7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658475100;
        bh=swWJKkGWRAT8EJ5gzXnLH40E4VFH/JvOdSTySX5AyCI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=k2EZUHSsS0/zO5ib1r4CbVkt0OXNhFkPQJw6qGtFMA4ixZweoqrTBxht+pyFw2GbP
         FV5UIs46vd2tnlJSicV25S5TyuhAcBna4phapLYOWmFmu0N4dDorARxFhvWrkWM8Gf
         lFeFecYvLZdKzr6nrIjt/sp+lS7aPmKmR0I7vERxQCeiE3nZbqscLX9GnyMRn904I1
         K/lofltVo4uSBfcBWNcMFjq/hBz9H4/Cw9D13khI74zJU5SwIJCoeITz8aaSHrmokj
         24GexYq3LUYUnWZ7+NSFAQg8uHjDbl7ywqU1yeQCuQM2AOlCcJgFTurirn/ejo66hD
         9FEPbPBO0Iqhg==
Received: by mail-oi1-f199.google.com with SMTP id o9-20020acaf009000000b0032f4e886b80so1944736oih.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=swWJKkGWRAT8EJ5gzXnLH40E4VFH/JvOdSTySX5AyCI=;
        b=qbtGDcQQmTVFSJfr+Zbae10529C0cuQS2jW2O4e4/lLlCupB2S7ehRrLBlDnrEJi07
         sb1WXHUCrsAQEcwC+CnTP8NM7NRyY37WbVW47IL6dsrLrp+ZX53ohoMz3khO0LYjwLZd
         jdVTERMf1xZSDnw9DGxmWL8AsKoVtUX6QfwLfhsk7Qe0F05mTJLOXr//ZXy+UDNRXAwZ
         sMzJaE454b79zFQMKoxZKtBzFmbbcfH/XT0xpZAE7XAXUx1O+9o0K9S1wXq5PTNCj9WA
         ihrlaSJ23kd+NzqsRJFykyQoiSF2/LEJJo6kW27P3nWl8GVk6a3mRI4NBYSyOyKcIwZ8
         avDQ==
X-Gm-Message-State: AJIora/Lv1sx2e9/e86nE5yf7phldu3PShVbc6TYn/KYYJCEMntdUXPh
        SH30b0JlyTT109dbGmlVhXZGVaLpmhwmdgdLQXbXGOWiZeJxIXyuTQlXvadgFjUyGNwly2Uh+62
        AQ8TnMiea7FNhvfPzqloezDUmnWKVtjBobm9NfNcstvLBxuFwlvsF0c+8wA==
X-Received: by 2002:a05:6870:2111:b0:e6:8026:8651 with SMTP id f17-20020a056870211100b000e680268651mr1014532oae.42.1658475099783;
        Fri, 22 Jul 2022 00:31:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vF6XuwGGBJdjebfFuLWgYPrcXmooyt9LQMz5+AKvdNuQdNsbLQpsDa/4L6DzBfwF/5/QfyWKfBFVmNhoRIK0Y=
X-Received: by 2002:a05:6870:2111:b0:e6:8026:8651 with SMTP id
 f17-20020a056870211100b000e680268651mr1014523oae.42.1658475099481; Fri, 22
 Jul 2022 00:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220705060014.10050-1-vidyas@nvidia.com> <CACT4zj8oTthEA8uEpSYQYURcc4qqp20xfw+DRaH=cS9NHGgZtw@mail.gmail.com>
In-Reply-To: <CACT4zj8oTthEA8uEpSYQYURcc4qqp20xfw+DRaH=cS9NHGgZtw@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 22 Jul 2022 15:31:27 +0800
Message-ID: <CAAd53p6RQ6GPkwWBTeqhOx_WXNLL8jrTe9n-zogaA_02QiDeUw@mail.gmail.com>
Subject: Re: [PATCH V2] PCI/ASPM: Save/restore L1SS Capability for suspend/resume
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, refactormyself@gmail.com, kw@linux.com,
        rajatja@google.com, kenny@panix.com, treding@nvidia.com,
        jonathanh@nvidia.com, abhsahu@nvidia.com, sagupta@nvidia.com,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 6:38 PM Ben Chuang <benchuanggli@gmail.com> wrote:
>
> On Tue, Jul 5, 2022 at 2:00 PM Vidya Sagar <vidyas@nvidia.com> wrote:
> >
> > Previously ASPM L1 Substates control registers (CTL1 and CTL2) weren't
> > saved and restored during suspend/resume leading to L1 Substates
> > configuration being lost post-resume.
> >
> > Save the L1 Substates control registers so that the configuration is
> > retained post-resume.
> >
> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > Tested-by: Abhishek Sahu <abhsahu@nvidia.com>
>
> Hi Vidya,
>
> I tested this patch on kernel v5.19-rc6.
> The test device is GL9755 card reader controller on Intel i5-10210U RVP.
> This patch can restore L1SS after suspend/resume.
>
> The test results are as follows:
>
> After Boot:
> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
>         Capabilities: [110 v1] L1 PM Substates
>                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> ASPM_L1.1+ L1_PM_Substates+
>                           PortCommonModeRestoreTime=255us
> PortTPowerOnTime=3100us
>                 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>                            T_CommonMode=0us LTR1.2_Threshold=3145728ns
>                 L1SubCtl2: T_PwrOn=3100us
>
>
> After suspend/resume without this patch.
> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
>         Capabilities: [110 v1] L1 PM Substates
>                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> ASPM_L1.1+ L1_PM_Substates+
>                           PortCommonModeRestoreTime=255us
> PortTPowerOnTime=3100us
>                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>                            T_CommonMode=0us LTR1.2_Threshold=0ns
>                 L1SubCtl2: T_PwrOn=10us
>
>
> After suspend/resume with this patch.
> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
>         Capabilities: [110 v1] L1 PM Substates
>                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> ASPM_L1.1+ L1_PM_Substates+
>                           PortCommonModeRestoreTime=255us
> PortTPowerOnTime=3100us
>                 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>                            T_CommonMode=0us LTR1.2_Threshold=3145728ns
>                 L1SubCtl2: T_PwrOn=3100us
>
>
> Tested-by: Ben Chuang <benchuanggli@gmail.com>

Forgot to add mine:
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

>
> Best regards,
> Ben Chuang
>
>
> > ---
> > Hi,
> > Kenneth R. Crudup <kenny@panix.com>, Could you please verify this patch
> > on your laptop (Dell XPS 13) one last time?
> > IMHO, the regression observed on your laptop with an old version of the patch
> > could be due to a buggy old version BIOS in the laptop.
> >
> > Thanks,
> > Vidya Sagar
> >
> >  drivers/pci/pci.c       |  7 +++++++
> >  drivers/pci/pci.h       |  4 ++++
> >  drivers/pci/pcie/aspm.c | 44 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 55 insertions(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index cfaf40a540a8..aca05880aaa3 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -1667,6 +1667,7 @@ int pci_save_state(struct pci_dev *dev)
> >                 return i;
> >
> >         pci_save_ltr_state(dev);
> > +       pci_save_aspm_l1ss_state(dev);
> >         pci_save_dpc_state(dev);
> >         pci_save_aer_state(dev);
> >         pci_save_ptm_state(dev);
> > @@ -1773,6 +1774,7 @@ void pci_restore_state(struct pci_dev *dev)
> >          * LTR itself (in the PCIe capability).
> >          */
> >         pci_restore_ltr_state(dev);
> > +       pci_restore_aspm_l1ss_state(dev);
> >
> >         pci_restore_pcie_state(dev);
> >         pci_restore_pasid_state(dev);
> > @@ -3489,6 +3491,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
> >         if (error)
> >                 pci_err(dev, "unable to allocate suspend buffer for LTR\n");
> >
> > +       error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_L1SS,
> > +                                           2 * sizeof(u32));
> > +       if (error)
> > +               pci_err(dev, "unable to allocate suspend buffer for ASPM-L1SS\n");
> > +
> >         pci_allocate_vc_save_buffers(dev);
> >  }
> >
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index e10cdec6c56e..92d8c92662a4 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -562,11 +562,15 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
> >  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
> >  void pcie_aspm_pm_state_change(struct pci_dev *pdev);
> >  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> > +void pci_save_aspm_l1ss_state(struct pci_dev *dev);
> > +void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
> >  #else
> >  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
> >  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
> >  static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
> >  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> > +static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
> > +static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
> >  #endif
> >
> >  #ifdef CONFIG_PCIE_ECRC
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index a96b7424c9bc..2c29fdd20059 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -726,6 +726,50 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
> >                                 PCI_L1SS_CTL1_L1SS_MASK, val);
> >  }
> >
> > +void pci_save_aspm_l1ss_state(struct pci_dev *dev)
> > +{
> > +       int aspm_l1ss;
> > +       struct pci_cap_saved_state *save_state;
> > +       u32 *cap;
> > +
> > +       if (!pci_is_pcie(dev))
> > +               return;
> > +
> > +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> > +       if (!aspm_l1ss)
> > +               return;
> > +
> > +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
> > +       if (!save_state)
> > +               return;
> > +
> > +       cap = (u32 *)&save_state->cap.data[0];
> > +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, cap++);
> > +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, cap++);
> > +}
> > +
> > +void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
> > +{
> > +       int aspm_l1ss;
> > +       struct pci_cap_saved_state *save_state;
> > +       u32 *cap;
> > +
> > +       if (!pci_is_pcie(dev))
> > +               return;
> > +
> > +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> > +       if (!aspm_l1ss)
> > +               return;
> > +
> > +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
> > +       if (!save_state)
> > +               return;
> > +
> > +       cap = (u32 *)&save_state->cap.data[0];
> > +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
> > +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++);
> > +}
> > +
> >  static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
> >  {
> >         pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
> > --
> > 2.17.1
> >
