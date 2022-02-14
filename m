Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132B34B42D0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 08:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241291AbiBNH2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 02:28:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241272AbiBNH2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:28:45 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9038932044
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 23:28:37 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BDBD63F1E3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644823715;
        bh=stPjNYKT8jIgNyF2oAsLzVlTYEd+kLoCabs8ksrQu4Y=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=pnzQaaYJvEVXMhqs1DSGLy399qZ4Jxt3RTDrRv/x9Li2KUt6tut9EBkegLBz7WbQF
         ehbz+/KB3zpjh2IRyTC3R0+QIzTM+C8QJeDG4NIFww4+8915ZzADbeMkuG62stj/5p
         Z5Akb3I5LlFGbhop7vkhBZIH9i40NbafBKwiTaz7yc+w6EEBIyJYlxe1t2Y+2Lp6TE
         sufBHb2+qBPXpkuFqhQdSmSzg1HUujILAeXe/lzsZmAOJ1UHJ0vrAO3CuPhFJx3M6M
         kQpaBu7U03Im+xs5nNPwV8xOUE4dgcwzCjxEkotDa/nuLmSyKfYwjDWnNon/IZ8t4u
         3gi/6BFVLhrEg==
Received: by mail-ej1-f72.google.com with SMTP id ho37-20020a1709070ea500b006cd51be5cd8so5435086ejc.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 23:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=stPjNYKT8jIgNyF2oAsLzVlTYEd+kLoCabs8ksrQu4Y=;
        b=yX7I5If+cHrSZd0Le8u4S8iySXASev/5FHFCqHejJFb4ul1HPPafatn56ALNERYm/E
         u+4SIIENzxqZN7VyYVO2a70S7ZzVghwTadpwjhCydkT1O+RYooDBiLVG6eu/uMBH64Hw
         g8ZJo2tY0KytdgGmCbX8Eo6UiF8rd29bTWRYkkUf+i/deKHdz55FL1Gb7P+Hu+9urPAD
         eQ793upkir+fTNJJ/rlKQ9HFRyH778LILTKrafSsMu7HTfAMQGusi4XnHLopzfTjU/5z
         LlYcEvcPXAed4v/7NB2EaENkHGcsbGV5evB9oZQb1bVAbHQgF0P3/4ZLdqUaYsvw21JV
         gnJQ==
X-Gm-Message-State: AOAM532QHG0FUUSIzEmviFhqPZ38mOsRDzKjGASvpaorqWLR55EKZNbQ
        PY2Zjh2edYEpAZraSu3TquLqUD/lkE2OxYoHlhOaem8IzzUC4FbaDdbpl704PdF6eyvu+4efy5+
        8E+nEVfQxkjO/e0yeKYtePOwJBuy4TsgpC0CWYFAdoQ==
X-Received: by 2002:a05:6402:51d2:: with SMTP id r18mr14335294edd.88.1644823715488;
        Sun, 13 Feb 2022 23:28:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzkInTRfFMDmTIqQtdD3PzZngKjB6pp383xOK8wNzWd9H/435n+6VZuhhh/TUUVZehlXzKrw==
X-Received: by 2002:a05:6402:51d2:: with SMTP id r18mr14335283edd.88.1644823715381;
        Sun, 13 Feb 2022 23:28:35 -0800 (PST)
Received: from [192.168.0.103] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id n2sm10098365ejl.86.2022.02.13.23.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Feb 2022 23:28:34 -0800 (PST)
Message-ID: <b7dad94f-4e59-cb4b-251d-05f747bb0862@canonical.com>
Date:   Mon, 14 Feb 2022 08:28:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] dt-bindings: remoteproc: qcom: Add interconnects
 property
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc:     ohad@wizery.com, agross@kernel.org, mathieu.poirier@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        evgreen@chromium.org, dianders@chromium.org, swboyd@chromium.org,
        mka@chromium.org
References: <1644813252-12897-1-git-send-email-quic_sibis@quicinc.com>
 <1644813252-12897-2-git-send-email-quic_sibis@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1644813252-12897-2-git-send-email-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2022 05:34, Sibi Sankar wrote:
> Add interconnects property to support the bandwidth requirements
> during modem bootup on SC7280 SoCs.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  .../devicetree/bindings/remoteproc/qcom,q6v5.txt   | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 

There were several properties added within last months, so in total you
changed these bindings quite a lot. Please convert them to YAML.


Best regards,
Krzysztof
