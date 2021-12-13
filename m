Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D39547301C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239922AbhLMPHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbhLMPHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:07:15 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B2BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 07:07:15 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id r5so14818557pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 07:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wmuKU/yN3EGitfvXJk13tFIWVK/CDHyZIX1jbSDni5c=;
        b=Wyf7pQ5tM2bSl793eOKIJambJoHqd6b4vqFrOm38l+0hoGoEuC+dGzCaO17DzxicuG
         U7+3vdNWRTjZwLwlTRzalAUkklsdXKVYZQ8RBR6HckYZYGmrtMWrOCtlwdfxaEOhIa0m
         BYWZi2Vc6VpIWwhknQRwP+tcYSuWooPXFVo5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wmuKU/yN3EGitfvXJk13tFIWVK/CDHyZIX1jbSDni5c=;
        b=t6zLHM64aC0ryQHZ7WAyafvBl8hBYbFecpu6PuAgqXGBQjoL456YwADuT0EmtcpnSd
         PGwST4+jPOsshBp0BVy03xgq6qnVvpnA2k/7YPtVp/aq+DN1wWBAuIGJGbA0+POpaf2a
         TniJxaH8uTNZfZ4YPsMpnOl+/lDw4iTcHulWknnJBvIt9jCae1/RVuH9u//lfF8Eq8WL
         lk6eSKTxptdmxoXFWScVYUym+w4QPIaj4fSs/YN3kIUOOIIBD9YRgD/omzzBJ5nYP2Zw
         wYrxi4TGEidyE9jjJQ4SGwk9ZOzWssU27CA9tBweP/anB9iaLdPjj6mnRbo7DhDyx49y
         SHpQ==
X-Gm-Message-State: AOAM531lnZ9SkJwai/flDBKbPIm3uErq5h40ROYw2Pg9b559dJj6Fdnt
        L7wgsc8Eo0H/n6fgapX4PspJBw==
X-Google-Smtp-Source: ABdhPJwJzjkTGVQC+Anjfc+ZBv4CymnaW1VG7s5Ay3avO0gZJy0il2SCP3V7uulVVkwcuf6gP0/c7g==
X-Received: by 2002:a63:110d:: with SMTP id g13mr32658100pgl.315.1639408034904;
        Mon, 13 Dec 2021 07:07:14 -0800 (PST)
Received: from localhost ([2620:15c:202:201:f4ab:25c3:a317:92ed])
        by smtp.gmail.com with UTF8SMTPSA id j7sm13235054pfu.164.2021.12.13.07.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 07:07:14 -0800 (PST)
Date:   Mon, 13 Dec 2021 07:07:11 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Panicker Harish <quic_pharish@quicinc.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        quic_hemantg@quicinc.com, linux-arm-msm@vger.kernel.org,
        quic_bgodavar@quicinc.com, rjliao@codeaurora.org,
        hbandi@codeaurora.org, abhishekpandit@chromium.org,
        mcchou@chromium.org, quic_saluvala@quicinc.com
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Stop IBS timer during BT OFF
Message-ID: <Ybdhn8mPrPBp397r@google.com>
References: <1639373496-28009-1-git-send-email-quic_pharish@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1639373496-28009-1-git-send-email-quic_pharish@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 11:01:36AM +0530, Panicker Harish wrote:
> This change stops IBS timers during BT OFF.

nit: avoid thing like 'this patch ...' in commit messages, you could just
say 'Stop IBS timers while Bluetooth is off.

> Signed-off-by: Panicker Harish <quic_pharish@quicinc.com>

Looks like this should have a ´Fixes' tag to make sure it lands in the
relevant -stable trees. Commit 3e4be65eb82c ("Bluetooth: hci_qca: Add
poweroff support during hci down for wcn3990") would probably be a
suitable commit for that.
