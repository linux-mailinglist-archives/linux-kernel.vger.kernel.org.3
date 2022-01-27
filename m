Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD5949EABD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239602AbiA0TCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:02:20 -0500
Received: from mail-yb1-f174.google.com ([209.85.219.174]:41967 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238995AbiA0TCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:02:19 -0500
Received: by mail-yb1-f174.google.com with SMTP id g14so11572527ybs.8;
        Thu, 27 Jan 2022 11:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZ+muMxsYAdOfLFCfYelUSEsPZYYdxDi6dVCQc7XtEo=;
        b=iEv4a7slcmntQU698Y8QAPK4Q8RNk1ObPSD6D+UqFsNt35HzAdQ+MeY8r/aqXj1rTS
         uJiM5PWFTq7sRHvMGud2k80+EEE9eU9fG3ESSnZ1wujbGfaa9FO6E+bwoOHNa51aEoTy
         N/1AlmC2vFaAAtItQqAgkpSwBAdFonVyy21tPCaOvxE8KkoxvuTyEFVZQUlrTAn8dy4n
         aTT7wVVIiiel8NB71XnVJNVpxory23i8hd5XbUMoRyEWUtJnrREow8itQPGiqA7R/VrF
         LJomre2Ft1DPItC6Dg08zFALj9HfJBu4eeqY4w+xf7sx8bIVgugo70X7y3GHCexMFabL
         dS+A==
X-Gm-Message-State: AOAM532Wgcwm5iZSF4IWHZ+p9SKOuqh5XNrNGghrxxLh1VyU+yywcYZk
        NF291u+5VDsu3JqLwf6s+hR9B1lobBmhWOebERM=
X-Google-Smtp-Source: ABdhPJwwuxh+M4WNtLnUTBMcxZ4UlZ/mbrCOF3BFwwbMrVAKbA9jwi4/N4qiIr/DrG4bB3Ls48sOKRNYl5cxrLmFhb8=
X-Received: by 2002:a25:c102:: with SMTP id r2mr8103463ybf.330.1643310138759;
 Thu, 27 Jan 2022 11:02:18 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0hvvYedSn5u-i7sjpoEHU4P65t7i1b2pVn=S1q0nHWgqQ@mail.gmail.com>
 <20220121210905.GA1114868@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20220121210905.GA1114868@dhcp-10-100-145-180.wdc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Jan 2022 20:02:07 +0100
Message-ID: <CAJZ5v0gybg+Wk+008UBFnm2WqrxowOarhst9Eh+91BN823mqNA@mail.gmail.com>
Subject: Re: [Bug] nvme blocks PC10 since v5.15 - bisected
To:     Keith Busch <kbusch@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        m.heingbecker@googlemail.com,
        linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 10:09 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Fri, Jan 21, 2022 at 08:00:49PM +0100, Rafael J. Wysocki wrote:
> > Hi Keith,
> >
> > It is reported that the following commit
> >
> > commit e5ad96f388b765fe6b52f64f37e910c0ba4f3de7
> > Author: Keith Busch <kbusch@kernel.org>
> > Date:   Tue Jul 27 09:40:44 2021 -0700
> >
> >    nvme-pci: disable hmb on idle suspend
> >
> >    An idle suspend may or may not disable host memory access from devices
> >    placed in low power mode. Either way, it should always be safe to
> >    disable the host memory buffer prior to entering the low power mode, and
> >    this should also always be faster than a full device shutdown.
> >
> >    Signed-off-by: Keith Busch <kbusch@kernel.org>
> >    Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> >    Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > is the source of a serious power regression occurring since 5.15
> > (please see https://bugzilla.kernel.org/show_bug.cgi?id=215467).
> >
> > After this commit, the SoC on the affected system cannot enter
> > C-states deeper than PC2 while suspended to idle which basically
> > defeats the purpose of suspending.
> >
> > What may be happening is that nvme_disable_prepare_reset() that is not
> > called any more in the ndev->nr_host_mem_descs case somehow causes the
> > LTR of the device to change to "no requirement" which allows deeper
> > C-states to be entered.
> >
> > Can you have a look at this, please?
>
> I thought platforms that wanted full device shutdown  behaviour would
> always set acpi_storage_d3. Is that not happening here?

Evidently, it isn't.

Also that flag is about putting the device into D3, which need not be
necessary as long as the LTR is set to "don't care".
