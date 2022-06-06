Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DDA53EED3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiFFTox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbiFFTor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:44:47 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E582BEA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 12:44:45 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id q11so5737143oih.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 12:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to;
        bh=G0s9EvK9A5j5jro8iyUi5/Ke5ICziVLB9PSRs9EAj4g=;
        b=hUP3AyLWcII1jU/38fRFnfKqyqfmKEc9qI+hlI7ikDhyY2bjlVB5vCV7BySY2ktEuL
         u7EfkpZRlCep9Z/DF440GwsfgW+xQeRzDH3U14cpDxTIgDN/jeJfEhaLdv+uSvSwWJ4N
         DykcvePs5dV24iZmueaG4njvIBUSWiOmK0vy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to;
        bh=G0s9EvK9A5j5jro8iyUi5/Ke5ICziVLB9PSRs9EAj4g=;
        b=drsRZRYGY31lWSEUuLdXK0sRwGRQnSq0pwJdG/1yGEFus4JFS3tScstz2sir7IdECE
         vDCX9G7PKAlX6CVD5uo9VmTa05gj9I+RwsjRqhBQBHRRZKxDT7t+V2kKuuOXutMHuBB0
         THKQL/c2doVAGgruSU/9nDfUEuR1FgXMLVesoln+QrWQdtx//CyN9nTKX/iRi23OsFnQ
         WAptfs4kRMwumD+It4lr8xEulLICjw5HVaS/FE/5AttXCPsp6XmvRR+HSgd8INQO4Ozv
         SH+WYqzqVzTjpSvYnYcTPm4maZi0GtISZJGMWAkcdtx35NMV/oLtEV5HOqhTP/nkKoAz
         QiMA==
X-Gm-Message-State: AOAM533y1h/pB10T45Z1/3oGd6JovRjE8MHFfLVSAyC5nD3g5yAAYbdc
        JhcYmJU87hChEZxZ9rQIjsr4LZK2TxsH/H7DogQLPQ==
X-Google-Smtp-Source: ABdhPJw4SXahKDGiLw6/yFgP9Er4tVXg0tDksdpE//wZ23cot1dq0FtgQ/4rLO8A7BnbpG+36/7yPgXnNjj9X/47njw=
X-Received: by 2002:a05:6808:1703:b0:32e:851e:7f81 with SMTP id
 bc3-20020a056808170300b0032e851e7f81mr5204846oib.63.1654544684903; Mon, 06
 Jun 2022 12:44:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jun 2022 12:44:44 -0700
MIME-Version: 1.0
In-Reply-To: <20220601075211.2117596-1-wanjiabing@vivo.com>
References: <20220601075211.2117596-1-wanjiabing@vivo.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 6 Jun 2022 12:44:44 -0700
Message-ID: <CAE-0n51JAxy0_znPeAevrE2MNLpe_rKmL0pcDOu9qApcRB1seQ@mail.gmail.com>
Subject: Re: [PATCH] leds: Add of_node_put() before return
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Pavel Machek <pavel@ucw.cz>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wan Jiabing (2022-06-01 00:52:03)
> Fix following coccicheck warning:
> drivers/leds/rgb/leds-qcom-lpg.c:1107:2-34: WARNING: Function for_each_available_child_of_node should have of_node_put() before return around line 1110.
> drivers/leds/rgb/leds-qcom-lpg.c:1286:1-33: WARNING: Function for_each_available_child_of_node should have of_node_put() before return around line 1289.
>
> Early exits from for_each_available_child_of_node should decrement the
> node reference counter.
>
> Fixes: 24e2d05d1b68 ("leds: Add driver for Qualcomm LPG")
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
