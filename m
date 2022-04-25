Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9F350D81F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 06:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbiDYEMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 00:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240964AbiDYELT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 00:11:19 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8EA37BD0;
        Sun, 24 Apr 2022 21:07:20 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id z16so13672501pfh.3;
        Sun, 24 Apr 2022 21:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ltFJY2eaY3E8yhVqJ69slyAc+WJkXgpA/nFEQ51FUbw=;
        b=qcMWakJyyyLmp1ZZYayHzqSFtKtiR80rYUfgoQmgXuggEeQk7QqCmHf2pYidBshw/7
         CSO3NKTv0y2p0c1LZ12ftlmpCNv+zomcjvlOfiYObCKNMx5gIpA9I4JWNIX7ehi6PvEp
         jPZt5eZ0uHJWVglXnH/Uyw2toDPAnLh8AxmR8jvtiZEwSyQBcXUoh4QjfxvpiC/q/hOS
         cnF9oENJuGi2rhCmcPU085geF4WoI26FUCiegld+aCfUQ30XIGJINWhtJa7juUanhqxO
         SBCNzUpgLc+XzdC+YnrRzWYvGifXGMcfYkdEpfc3Dmb1zgwrI9R0k/hIsDaB9abJgyzQ
         sZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ltFJY2eaY3E8yhVqJ69slyAc+WJkXgpA/nFEQ51FUbw=;
        b=ar2N2Ib6h+rOqKV4Z9P/9X9eyJ8fKGdXzrQ0b+djO5XPrLQ57f8vlNkgPs2U3VrMU+
         TrmSfGlD3H8cp7m9zAZGjcqQ0Z6/PzdGR8cKNCeLydFd/SdF9iz4aHrw7N0yGxgnalZr
         1KqYAcOBhzIhQl7VzdyjedDV7mQz/FzbzW2nx11r7/i3shZT5nqfwd3lvZnKCLbTJpPK
         sge4Soi4dyyi1/On6aI4/tz1ViKg2WUHSWfBG8p0P3IfNyOwP1u6/0/6KJSi7kDHyIsu
         lQ5hxSQy+d+7goCP1E2vW4aqvm/RFotSaWyiIpgpQu0aLVV7cn/Y70MSxLJq9OLVP+l8
         8RaQ==
X-Gm-Message-State: AOAM53077wNdwzj+TB6ss0Nmv0dXs84ao9sgkDenql3UAe9pzxx02R7u
        3uybun41sbaL18Q1KZV1WvE=
X-Google-Smtp-Source: ABdhPJweSU6Z+5qa3s75ZyG0EM3sU8ZFEeS+xSECS7B576C6dfhP8o1cFUprC9Esc5QDC97Ci8TxBA==
X-Received: by 2002:a05:6a00:248c:b0:50a:d0c5:374b with SMTP id c12-20020a056a00248c00b0050ad0c5374bmr16964162pfv.47.1650859639402;
        Sun, 24 Apr 2022 21:07:19 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:282a:d50e:e0fc:c145])
        by smtp.gmail.com with ESMTPSA id y3-20020a056a00190300b004fa2411bb92sm10393004pfi.93.2022.04.24.21.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 21:07:18 -0700 (PDT)
Date:   Sun, 24 Apr 2022 21:07:15 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     corbet@lwn.net, sre@kernel.org, robh+dt@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 3/5] input: misc: pm8941-pwrkey: add support for PON
 GEN3 base addresses
Message-ID: <YmYeczmNcN/sVUPk@google.com>
References: <20220422191239.6271-1-quic_amelende@quicinc.com>
 <20220422191239.6271-4-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422191239.6271-4-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 12:12:41PM -0700, Anjelique Melendez wrote:
> Currently, PON address is read from the "reg" property. For PON GEN3,
> which starts with PMK8350, the "reg" property will have both the PON
> HLOS and PON PBS addesses defined. Add support so that all PON
> generations can be configured.
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>

Applied, thank you.

-- 
Dmitry
