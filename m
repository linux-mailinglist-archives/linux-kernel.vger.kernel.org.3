Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5366A49001A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 03:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbiAQCCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 21:02:17 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:55436
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236757AbiAQCCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 21:02:16 -0500
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E88133F1C7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 02:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642384934;
        bh=eGLOAnwE0aUbZuYKRk6VuezFSjbIQdlMFb6mJBdRNeE=;
        h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
         Content-Type:Date:Message-ID;
        b=qh5wEQ10uoe4xf9f+KYSzPABd+siupRcbPoxPJ9KFpXdgW1JImGGMG84twdRSasN9
         1SXAe14lr0pSoftuqpFv2ZV54a4Va1LPICK1CJzC0F4W+wlVIhj/YdyPQ0mHUVmBnc
         OYg+bb5mff6aS6WDmJSDdm0M0Xnz+wzy5Mf4VGuh03gEBvmwczM5nIprFD/5dm+Ty6
         fJxeP7qWwLCvpACiGUH2zpDCKbgjnRujhy78HeJvclgBoslq2MOR0tox9G9dIQuMLi
         n+BTCwFRR/3RALe9dDkXTfC4ZKM7XUATJkDMBs94i6bzKfH1UM8gN7NlmTADfEMjvI
         k62y3mRM1F3vQ==
Received: by mail-pj1-f69.google.com with SMTP id d92-20020a17090a6f6500b001b35ac5f393so9925778pjk.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 18:02:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :comments:mime-version:content-transfer-encoding:date:message-id;
        bh=eGLOAnwE0aUbZuYKRk6VuezFSjbIQdlMFb6mJBdRNeE=;
        b=y3ySs40n6EbZTxUqdiWHuysnZx/Dikee1ScRMDjO7bjvzLUnNaj5Ve7aBnV6UP8VkF
         UxyugwS/W4Ib/yIEI8Pj0KKg+1SU8AIkYJVIothkHhz673lzdu6BDZ2yW2J+VRQjA5sT
         CNC92f6pV+cB/bZz5k85QTxtd//DCcX971wyCG1jdDAoCTZvami/n1ZMzaBLb3xSO6cc
         vuLRHcuaKZVHwS78StH0lBZ/7bKZlTALOOPSo5tI3U2PwIg01LZWJlCRExt5kSxtJsJ9
         MJ5lgJJtYf12jB6mQa2rPSKLj755wR72DkZg85lNOqblG+jakGhFYmMmutoLTe+LPJEA
         48SQ==
X-Gm-Message-State: AOAM533kscTWM1QbZyRasaf62AmDrxfhWe+gdT4MpHyvaNpRC2Qri0R+
        udEqKuG8iIBRSd1C8YHNUdlCOVWukMCHGEITpVE3cwr+zLIqS/8TonHBKsiLcDUfFOIAoeNxYx9
        ctzxKDwe4T3WZSCgeRJ9Gy+Ib4j8qF3Hgavzneun1RA==
X-Received: by 2002:a63:343:: with SMTP id 64mr2751190pgd.261.1642384933277;
        Sun, 16 Jan 2022 18:02:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfweBwKmX4JE8C/KTqmXW19SVbTHOJ0NKDt0p1KXo6s7VK2n/9ju4sz2UvVyi+mLmEZ/KUHA==
X-Received: by 2002:a63:343:: with SMTP id 64mr2751168pgd.261.1642384933062;
        Sun, 16 Jan 2022 18:02:13 -0800 (PST)
Received: from famine.localdomain ([50.125.80.157])
        by smtp.gmail.com with ESMTPSA id s21sm11897566pfk.55.2022.01.16.18.02.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jan 2022 18:02:12 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
        id 902946093D; Sun, 16 Jan 2022 18:02:11 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id 888C9A0B22;
        Sun, 16 Jan 2022 18:02:11 -0800 (PST)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     =?us-ascii?Q?=3D=3FUTF-8=3FB=3F5a2Z5a6I6ZGr=3F=3D?= 
        <sunshouxin@chinatelecom.cn>
cc:     vfalico@gmail.com, andy@greyhouse.net, davem@davemloft.net,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, huyd12@chinatelecom.cn
Subject: Re: [RESEND PATCH v5] net: bonding: Add support for IPV6 ns/na to balance-alb/balance-tlb mode
In-reply-to: <5c8a286b-932b-135f-5da4-68d18cfcb891@chinatelecom.cn>
References: <20220110090410.70176-1-sunshouxin@chinatelecom.cn> <11285.1641842636@famine> <5c8a286b-932b-135f-5da4-68d18cfcb891@chinatelecom.cn>
Comments: In-reply-to =?us-ascii?Q?=3D=3FUTF-8=3FB=3F5a2Z5a6I6ZGr=3F=3D?=
 <sunshouxin@chinatelecom.cn>
   message dated "Fri, 14 Jan 2022 17:07:04 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Sun, 16 Jan 2022 18:02:11 -0800
Message-ID: <14104.1642384931@famine>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=AD=99=E5=AE=88=E9=91=AB <sunshouxin@chinatelecom.cn> wrote:
[...]
>> 	As for the RLB functionality (i.e., the balance-alb remote to
>> local load balance), that is not implemented for IPv6 and this patch is
>> not providing an implementation of the RLB logic for IPv6, so I'm
>> unclear why you expect it to work, or what the "mismatch Bond6
>> specification" is.
>>
>> 	To be clear, implementing RLB for IPv6 would include what this
>> patch is doing (adjusting the content of NS/NA datagrams), but a
>> complete implementation requires additional logic that isn't here, e.g.,
>> adding IPv6 logic to the RLB rebalance code, connecting NS/NA
>> manipulation to rlb_choose_channel(), and likely other things that don't
>> come immediately to mind.
>>
>> 	In summary, it sounds to me like the actual bug originally
>> reported (with the now-omitted diagram) would be resolved by assigning
>> NS/NA datagrams to the curr_active_slave, and supporting RLB for IPv6 is
>> a larger project than what's provided by this patch.  Am I understanding
>> correctly?
>
>
>Thanks your comment.
>For the simplify, I would like to resolve the inconsistent mac at first by
>assigning NS/NA datagrams to the curr_active_slave by V6 soon.
>Supporting RLB for IPv6, it looks like hard a bit and I wonder if we can
>resolve it in another patch=EF=BC=9F
>any comments?

	I'm in agreement that the first step should be solving the
immediate TLB NS/NA problem, and the larger task of implementing RLB for
IPv6 can be done separately.

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com
