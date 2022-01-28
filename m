Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122CE49F6BC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347773AbiA1Jz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347766AbiA1Jz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:55:57 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBEFC061747
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:55:56 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c190-20020a1c9ac7000000b0035081bc722dso3665262wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9OcTQzGa35kRYA8wkuNpPKhajo2EEIRQ92GCwJmiBbs=;
        b=OKzgZ+Qew+4rwieXFFdzliUThMTozaLlZNrIZD9v1UtC/eCM7/HIzyc97uViD69IlC
         t7dcWSD7HDCp0rc5PduUFd0KOvlY/6SChiC4MrQrOIRYItrGh0AOD7p34Vybt+0wSzDv
         QFVyG3cqCqVDg2vy3ApKlga0BSpY0hkGO4vd10LcGy1e2X8y/xxwpMXZGhXqWIIh483H
         OKPnyOPtMRy0SwyMLy9NstU7w2JsHfZjsAp1KcmedjpqPCZmkakt1KhyiIyTTYhjPNt0
         9+cIWHZRuCaOCcNie5P3vSpV+bJhReEwKtZlnq9m8dzDKWZv9HhJdQEjgFUkyG9Uw/u7
         ayJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9OcTQzGa35kRYA8wkuNpPKhajo2EEIRQ92GCwJmiBbs=;
        b=hrgx25dDv4TpM0E/2YfjzEObr0AeFwsi3qDfuZT0l2kKGIN9qK9vctB+wEYbvs4s8g
         rw5HPfiy3uZt7Vmv7D+q1p/nrYCxYzhn4aoX9eUwXCiAPNgaJ8GuQGHEBjMeQnfiBMRn
         RPfy3D5PyT5rnPhoGRoSZ3SoAd6wFZmT8QT4uYAQexKGjsAbIIG9PF/o1CUFKNhscu0K
         UryHxFuEdxhxxuxb4yZzExI2ZG742dI0Kd0itzKPSDo5slryPDXsizyE9524cKHYjngu
         cI3kPmTART9tZHG0/WmEIxsoq548Sgm+GmduT1aU44PZAWHO+lmPkenma1WDDO/s0Asz
         7d5w==
X-Gm-Message-State: AOAM531knuI8jrBH5HqRM8A8tAN8SKrK0J7D2HuRheUAnCVDbtCihBa+
        0gBTPTCO28PHXcW14XKZYRKW8w==
X-Google-Smtp-Source: ABdhPJysznJTYs5X/q0fgqi/MbF+pd7Zm0F6oR4XCtNJ0BNgC1nwC/hhTAUF8qQs3EvmJ9WrWsrlww==
X-Received: by 2002:a05:600c:4fd2:: with SMTP id o18mr6688322wmq.152.1643363755476;
        Fri, 28 Jan 2022 01:55:55 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id t5sm4353423wrw.92.2022.01.28.01.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 01:55:54 -0800 (PST)
Date:   Fri, 28 Jan 2022 09:55:32 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Pavel Machek <pavel@denx.de>,
        Oliver O'Halloran <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] PCI: ACPI: Allow internal devices to be marked as
 untrusted
Message-ID: <YfO9lPJe0RuVyxFf@myrica>
References: <20220120000409.2706549-1-rajatja@google.com>
 <20220121214117.GA1154852@bhelgaas>
 <Ye5GvQbFKo+CFtRb@lahna>
 <Ye/X7E2dKb+zem34@lahna>
 <Ye/btvA1rLB2rp02@kroah.com>
 <Ye/zTHR5aCG58z87@lahna>
 <CAJZ5v0gitdeEAxcgSoB1=VHA9FnRdCtmUqA_cN_f1a2yFRDghQ@mail.gmail.com>
 <CACK8Z6H2DLTJgxgS3pcvfOh=5S8cxEMKvwEPfB9zoVf1g2H_UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6H2DLTJgxgS3pcvfOh=5S8cxEMKvwEPfB9zoVf1g2H_UQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 02:26:07PM -0800, Rajat Jain wrote:
> > > > And shouldn't this be an ACPI standard?
> > >
> > > Probably should or some supplemental doc but not sure how easy these
> > > "properties" can be added there to be honest.
> 
> AIUI, the principal comment I have received here is that this property
> needs to be documented somewhere. I agree.
> 
> Rafael, do you know if this new property can be added to the ACPI
> spec, and if so, how to do so? I'm happy to initiate a process if
> someone can point me to, I just hope that publishing a new property to
> the ACPI does not have to block this patch.
> 
> The other option I was thinking of was to use the same property name
> (say "untrusted-device") for both ACPI and device tree platforms, and
> document it in Documentation/devicetree/bindings/pci/pci.txt along
> with others. Since there are other properties there that seem to be
> used similarly (Mika highlighted some below), perhaps that is an
> acceptable solution?
> 
> I had one last question on the property name itself. I was trying to
> understand why a property might have 2 names i.e. "external-facing"
> for DT and "ExternalFacingPort" in ACPI?

I picked "external-facing" for DT to be consistent with other device tree
property names. There doesn't seem to be any CamelCase in device trees
[1], so we should probably keep that convention for new properties as
well. The internal device_property could use the DT name and the ACPI name
can be different. We do something similar with properties "pasid-num-bits"
and "dma-can-stall" which are extracted from the IORT table in
iort_named_component_init()

Thanks,
Jean

[1] git grep "\<[A-Z][,a-zA-Z0-9]\+ =" -- '*.dts'

> Are there any naming
> convention requirements that require ACPI and DT property names to be
> different? Is "untrusted-device" an acceptable ACPI property name?
> 
> Thanks & Best Regards,
> 
> Rajat
