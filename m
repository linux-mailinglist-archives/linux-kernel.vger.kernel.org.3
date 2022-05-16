Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F4B528D8D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345205AbiEPS4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345187AbiEPS4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:56:36 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6FA10FE3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:56:35 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 31-20020a9d0822000000b00605f1807664so10682817oty.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=MJx3UmouNiWNfqqDYIOXDPwtYD13RhsMbDA6eXvF/Sw=;
        b=gC6y+jKfV/qj1AmBnZ0KeN/8oQPBeF/cIWz93DRzjsfOf05ZsxroN7urSre4hLmM+m
         E7iQvgJYIVhZ44wg+GSt5fEC6xzfb3wQNbpYqkC5FT4OjpardXbuqt0QagsXt2msNd9U
         gwoWARsqNYkWrUQqPZnJ5lHKag902yPhLHy1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=MJx3UmouNiWNfqqDYIOXDPwtYD13RhsMbDA6eXvF/Sw=;
        b=1mXf2dixWO6pXqVnDi49FENYZdaw7Q6idJtTScQCU4I2BDivGGGZyvVLPt03KAdpNx
         KEXlkVYbigrIKlJ15AkIvg9SPOjgUfuxkJOkK0we5J6ocbO+L+xYZG10Lka7PQ4f5WMH
         C7E+N6iKoOThfVGsfUsRKOPEjJs3t5t3j0wDAPn3/KvPf7vpHg66FgLdg3K3p1eqJWXa
         YuZ7zDzJAv1i9RvPANa6zm23lwZeXHZESu3TxYKORRXeklRSIpQVgsKQU5nRV3WkYKtn
         OnKTnCc7aS2e2t1lLp7T262QIY/n4ubQ7hjfhymq7ELnO0QdS9IWLEoekBk261zDADmb
         TxWQ==
X-Gm-Message-State: AOAM533DLnP4FOriI6MaxuJKsyoQjkCsRkHxQj6iFWMLq946zXY2oH6k
        r2OF836xPq5X1ciaN9oC4mkTHzTW5bM3MABYLW3P1w==
X-Google-Smtp-Source: ABdhPJxW2uQNcDHTxeJaPy9aURBWojLRwuduj2z6Yw/04X8J1t4LFTEC6Ac0cOZHWux42qZgWJxITqgvegNN26EH6JA=
X-Received: by 2002:a9d:63cd:0:b0:606:9e7f:79f8 with SMTP id
 e13-20020a9d63cd000000b006069e7f79f8mr6668728otl.77.1652727395199; Mon, 16
 May 2022 11:56:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 May 2022 11:56:34 -0700
MIME-Version: 1.0
In-Reply-To: <1652275113-10277-7-git-send-email-quic_c_skakit@quicinc.com>
References: <1652275113-10277-1-git-send-email-quic_c_skakit@quicinc.com> <1652275113-10277-7-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 16 May 2022 11:56:34 -0700
Message-ID: <CAE-0n500ceOR0Fr6=DR9D=hXuDjtyNNVnP3J_B2RMLY5TGCUbg@mail.gmail.com>
Subject: Re: [PATCH V12 6/9] mfd: pm8008: Use i2c_new_dummy_device() API
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_jprakash@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-05-11 06:18:30)
> Use i2c_new_dummy_device() to register pm8008-regulator
> client present at a different address space, instead of
> defining a separate DT node. This avoids calling the probe
> twice for the same chip, once for each client pm8008-infra
> and pm8008-regulator.
>
> As a part of this define pm8008_regmap_init() to do regmap
> init for both the clients and define pm8008_get_regmap() to
> pass the regmap to the regulator driver.
>
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
