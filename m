Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6A85B1186
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 02:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiIHAnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 20:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiIHAni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:43:38 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99AEB2777
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 17:43:37 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1278624b7c4so22069216fac.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 17:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date;
        bh=0NDOpRRZXKSoT0ag7W3GTB/utuZq1B1nc2pEFCLA+SM=;
        b=hljcWqxcGFzN8FxmRrg+VJublQkjR+8ByfCr5igMQXtQycm1WkYNnMcUWj781qo0EY
         93TpacIccciqXXTc4QWx9paA5MA5TLas5OhhQ05r5Top/X3/MbuiToSgU/W0z1TxO7ez
         IbG63SykKaqLNvV3z+iTBb6XMhRo/AXzo/WKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0NDOpRRZXKSoT0ag7W3GTB/utuZq1B1nc2pEFCLA+SM=;
        b=UI7Sr/gVXyoyUx9rrl6WWa/VYOEe2fr4VOccEIDD04o1bS5/Q2SO7Q2rRxcL/amac0
         HUsUesA90bCeSJpuePHXo9Vkb1+8vUO7qUX988212tZG5UUMu323Z/ZzE57dAhUwdCUb
         3dNei5bmzyvbC9TqH9M+7AzfhCPj/D3KxUSs0Ao3qZJ4OQZbgN3g0TjbFCQfXiX6/Eq4
         KMHel0K2VsFhbzRXknA4biWIBKsyyyuWzVDC1tR0VpQZ0gGGcuNXK+Johc1TbxtMfHvS
         CvNYk2Nlyet1svA5CGvNO1kofkzSR5H4er+d+zBtJ6IxSgSODaViToNi1j3atdOUX1z0
         Vq7A==
X-Gm-Message-State: ACgBeo0bQbbmmrIb9bDVoxuWj6ikyG6yd653u4Ge5u/1chWM0KnxJHfe
        Gk2Ci24hPOpsVrAXd4Noid3FWHt906krQxeUccFgbJfsJng=
X-Google-Smtp-Source: AA6agR7BSPSs98vSFaJfDu5M4EnQqDgWgsMOH8L9mxK0EGPdtbJUMA3iEP1v0WNDQ7RL/nqHOQkbX6Dg29/ju6EDcKE=
X-Received: by 2002:a05:6808:bca:b0:344:ef42:930f with SMTP id
 o10-20020a0568080bca00b00344ef42930fmr436019oik.0.1662597817334; Wed, 07 Sep
 2022 17:43:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 Sep 2022 19:43:36 -0500
MIME-Version: 1.0
In-Reply-To: <1662564702-7253-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1662564702-7253-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 7 Sep 2022 19:43:36 -0500
Message-ID: <CAE-0n52q3419nOSh3WOfyqhnDdFUSS4Oq4h-0CPQOZkQ54_UNQ@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom-geni-serial: Replace hardcoded icc
 flags with macros.
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, andersson@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vijaya Krishna Nivarthi (2022-09-07 08:31:42)
> In suspend/resume routines, icc flags are hardcoded.
>
> Replace the hardcodes with macros available from header.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
