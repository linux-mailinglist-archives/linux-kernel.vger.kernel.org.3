Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42A4487B79
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 18:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348592AbiAGRcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 12:32:51 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35496
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348575AbiAGRct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 12:32:49 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 273D93F17B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 17:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641576762;
        bh=reiJbrHsd6HUY73y6dW3uK1fLpWZ0z6nBvTr3IYdF1I=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type;
        b=CDBbniOLG2fzCedU1W1uGhuW1uSYpVieoy9rDDZ7SmyfeNfMGQBJZUvWW8KoFK2Bp
         fVN+3zZvlLhhDRgxvwrgU667tXL8OuunNBMsICFGYyMq2X2u4hpGSnF9wiwKSPcoyu
         hoSl9wZDDctBJGrVOpG/SSlLOe293XpBcqYpLTVH56gt1SEGOm2nLBMlVDECMitUMu
         +J7HfBPfhY2lGqY3u02eyzE+l+J3X7uellmANesYi+ieq9ZCmoy3L2WDrnNiXz5EDq
         /ubwIc6DmKYgcQpWbbwYL0nq4zY71BFOX9rXNyad+qBUqwxk98kly3hW0234SiydNy
         w8kOu3ViI+3Ig==
Received: by mail-ed1-f71.google.com with SMTP id z10-20020a05640235ca00b003f8efab3342so5239289edc.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 09:32:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=reiJbrHsd6HUY73y6dW3uK1fLpWZ0z6nBvTr3IYdF1I=;
        b=z4bMJG1VosG4SAwHKas/rIQ+iWmPtIfX8Lds/V9zwfWXgHwdlt9RXWJyNVYRzJrRvn
         LgOQN6Tkzf3aqGcvL53EQSJxmLEZ6gHTWWCu3OWPImHkG2NsOg/jLeRWh7NGnCzI0UF3
         0Fy7KXby1REshZgNn29whkU4Dk7+FC6W7ipvLvjMPzkbqSCkREeQLlEmlNtss24RgVLa
         XhJP4bzdyMpJYjUnjutLF6R5AW27cSCBbXyPb7IES6fpIHGfua2p8zATJGybtLKBXLs+
         ojuqMqOdu4VE8Y6Z0w4qKn2ByBrRyGFmujjR8ZcdawABEuAf9k5je3HM0u00U+VFxxj+
         nIig==
X-Gm-Message-State: AOAM533ZFGH7k6zmbnq3i0SQ3h28UR3uYXMrAEYQDrPKROHiuF25HnOu
        6UFIWnOMcLIac2Jh0m6uiyHzbf+gpiXB1UG83fDDphp6TB/+QR0Hn6E2IvUPLmfYzS41GJFYB4x
        xFbmyYzNEb0EkY6tCdgpIMyQN37B6QKoR1RNSQtXfCQ==
X-Received: by 2002:a05:6402:1e88:: with SMTP id f8mr58042948edf.2.1641576761933;
        Fri, 07 Jan 2022 09:32:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymgxobe9HSGQM+bXdtE+Ng/EHT7YtrMrHAaqPUP6/VX7AeRCAV/M1g3xczPO8LehBpBNlmtA==
X-Received: by 2002:a05:6402:1e88:: with SMTP id f8mr58042935edf.2.1641576761781;
        Fri, 07 Jan 2022 09:32:41 -0800 (PST)
Received: from localhost ([2001:67c:1560:8007::aac:c1b6])
        by smtp.gmail.com with ESMTPSA id dd5sm1583151ejc.59.2022.01.07.09.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 09:32:41 -0800 (PST)
Date:   Fri, 7 Jan 2022 18:32:40 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Stefan Roese <sr@denx.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Marek Vasut <marex@denx.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: "PCI/MSI: Mask MSI-X vectors only on success" (boot problem on
 c4.large)
Message-ID: <Ydh5OCudJKz5Y7jc@arighi-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

I'm experiencing some boot problems on c4.large instances on AWS with
this commit applied (system stuck at boot - no oops or panic, just
stuck):

 83dbf898a2d4 ("PCI/MSI: Mask MSI-X vectors only on success")

If I revert this commit the boot completes correctly (found doing a
bisect).

I'm using a 5.15.12 kernel. Let me know if there's anything I can do to
better track down the issue. For now I've just reverted the commit.

Thanks,
-Andrea
