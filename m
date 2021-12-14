Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77FE474414
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbhLNN7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbhLNN7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:59:45 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8258FC061748
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 05:59:45 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id y16so24181347ioc.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 05:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=DMsts4DALXAc/4OMVE7nKmsm4oHZCd35/gmAzU5+dTQ=;
        b=lG6LuESlJ4B308I07WHHKuqx5O3r/OW65GXeh4wWWlyyI4EkzBAntlfV9dHOmlEolx
         XaQzKVB/7WyJu3XPVzWIAPfOwvD4PVACuorAykKh2tjfEIF02MFBjXDliLF8086tRBv3
         PrjZsxdgpLZTUoDcU16uFXTSHPMkR3PQ6+XemI3sNIQMaj2yvjlf3WlNOND8X824XtSF
         E9UkZ0jg4ttFL8Xuwj3NHPQA0RP+Xuqa5Kb7UGHH05/nfa/S6XkFefA2llHOf65ioYcv
         3E9BCfx5AmJv1g7/7RsnGo4Z3Iu1HDi2eLlwsQObttiLxJo9a+if8C+bO0YYeTodRAqY
         Dg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=DMsts4DALXAc/4OMVE7nKmsm4oHZCd35/gmAzU5+dTQ=;
        b=rAWlcJXPOXem1zNw3F0P4Fu94EG0ooQHbCiIW46CbfrWtIAoKVUYrbGMa1QMrW8XQS
         L8bDY6+UVd8wtcMowNE/iihDaOZ6yVC+41GGYnKlOSx/5fKowTw+vdMrHGiNlv8czq4U
         YD/knNRYPOkvz/L0AJTpSme2bPtpuWQWyy6TSaq/35NuiISGI3gQQWw9nVR6wUWvJdHL
         3wXwAnWknJv3q390SPVwb+sq4UdcL09qvo7wOknLSqb0I82XCSZ++fKdYnPlStuwG9rj
         UzdvVSbEWIN3R9ma6NvYWedCIihSSt0LCZfFlt35pv1yskp4hGAj80l2XGx93IXd9cm3
         1Lhg==
X-Gm-Message-State: AOAM532tdrbC26TJ56mPqWrBWbeKozXlZu7y2tLZkJElyF4iPfE90VX/
        awD/5qR4pmgSvhIytojiEv1CRZieOHr9SA==
X-Google-Smtp-Source: ABdhPJy7KeYpJWVcc6tu3G+V+pMOg2OSAAl9uEPFaXTi58pXfepSftxLmnmO0y0O6J0QGX+ww67z8g==
X-Received: by 2002:a05:6638:348f:: with SMTP id t15mr2867875jal.272.1639490384660;
        Tue, 14 Dec 2021 05:59:44 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id r18sm8793747ilh.59.2021.12.14.05.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 05:59:44 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Philip Kelleher <pjk1939@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Joshua Morris <josh.h.morris@us.ibm.com>
Cc:     linux-pci@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
        linux-block@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Bjorn Helgaas <bhelgaas@google.com>
In-Reply-To: <20211208192449.146076-1-helgaas@kernel.org>
References: <20211208192449.146076-1-helgaas@kernel.org>
Subject: Re: [PATCH v5 0/4] block: convert to generic power management
Message-Id: <163949038206.174299.12080416577354381479.b4-ty@kernel.dk>
Date:   Tue, 14 Dec 2021 06:59:42 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2021 13:24:45 -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> This is a repost of patches from Vaibhav to convert from legacy PCI power
> management to generic power management.  The most recent posting is here:
> 
>   https://lore.kernel.org/all/20210114115423.52414-1-vaibhavgupta40@gmail.com/
> 
> [...]

Applied, thanks!

[1/4] mtip32xx: remove pointless drvdata checking
      commit: 2920417c98dbe4b58200c12fc9dc152834b76e42
[2/4] mtip32xx: remove pointless drvdata lookups
      commit: 9e541f142dab67264075baaf8fd2eb4423742c16
[3/4] mtip32xx: convert to generic power management
      commit: cd97b7e0d78009b45e08b92441d9562f9f37968c
[4/4] rsxx: Drop PCI legacy power management
      commit: ac6f6548fcb3c6da8ff1653a16c66fc1719a2a3e

Best regards,
-- 
Jens Axboe


