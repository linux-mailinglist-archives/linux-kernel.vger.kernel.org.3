Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73AB4ACA16
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 21:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241454AbiBGUJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 15:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239990AbiBGUHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 15:07:11 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96BCC0401E5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 12:07:10 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 92A323F203
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 20:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644264428;
        bh=4dYOe+nDDh4aVyn34qFZwR7+XYTuNxTI3b3m5/CxGfA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=HSfdaizQSYqblyB+QdiLdn8HXBbyehrKHGrbdBVJxVwNvkoseRfB+uT7TTxE6hWv1
         KHxmkx+GIpLN4Xh29Qdh2IIZO2cLF2GNdpPgIclW/uX+0V7i0sWfdjhXrKhfKy/toU
         vMXO5qCxdi4qufoz65aAeXiU5YPHOHdkfKi5kPNCo7uH8KXThPyUP7e4rpSdVlpYb+
         E4BkZeqvxd2sbcQK4KmR4de41YIFJAWuuoDPrTnI9I8bym49PjL5cvriKGH1Pldxq1
         Vw5ZMw8XonSYWdoPMiNmDfuBBmOGrCin/JDTPO2+AO2gIfXULtqaJlLZv6Wj0IFyTs
         jJhlwEZ/UoYFQ==
Received: by mail-ej1-f70.google.com with SMTP id 13-20020a170906328d00b006982d0888a4so4727842ejw.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 12:07:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4dYOe+nDDh4aVyn34qFZwR7+XYTuNxTI3b3m5/CxGfA=;
        b=LiDbRGUcl4Jx6wABC5nQh7Zyjo7PBX8CyPIJcWl+0W7swbOlriHmk1woGQjumkh25i
         AJhNW2pBBhlv2mc30PfdSRGc0YqekyEmERN7jkJNMcXz+4MiCz2NRwGErYgw8yrZwOGf
         jiw7/fsT12pgz+TwDW/dxcCtHSeWCvJrmTGpJsFuRnBCvX3u6qzsQALiZskWKXyNjszA
         X1KHZV0w4cxK6qkD2L2BY9HJbGJT2/24TnkUPfC0IyIxrMU5OiU6Ew8kvCMhvA608klb
         ebE6/rKN1Dn6eafEJ2k2gq0ET+Y4onEYusEpDCJnjbBg8KFk5zbyZdcQ5kZrET2mQ9SJ
         PEIw==
X-Gm-Message-State: AOAM530pBiTR36e0LPFAWkjiq3/ObVxxHuZcdbz2qBWdmRHBnUkgezr5
        q72u+Bp13IoQ5JOHA0MB2vuYlKIWOC6MSGO4jM9pz2+cb0mdZ19tcAYwPljDa6TuaRkpU//aQ/o
        b/J04/ZjN9M6ndm+3DvxcDfFqpSzfVNLYbtwGLzj9TQ==
X-Received: by 2002:a05:6402:4385:: with SMTP id o5mr1182573edc.48.1644264428207;
        Mon, 07 Feb 2022 12:07:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7gqrf2i0cbGWZf55YEN4mmZLmIUrR0Ghfw9MTtHdiGRjZWYb5iwRVnSs+fii5J+1BSjqQDA==
X-Received: by 2002:a05:6402:4385:: with SMTP id o5mr1182563edc.48.1644264428045;
        Mon, 07 Feb 2022 12:07:08 -0800 (PST)
Received: from [192.168.0.91] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id s9sm5783229edj.48.2022.02.07.12.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 12:07:07 -0800 (PST)
Message-ID: <9bb00b0c-6d5d-3dc3-776b-6ecce0268407@canonical.com>
Date:   Mon, 7 Feb 2022 21:07:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 5/5] mailbox: imx: update author and Copyright
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
References: <20220207095832.1590225-1-peng.fan@oss.nxp.com>
 <20220207095832.1590225-6-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220207095832.1590225-6-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2022 10:58, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add NXP Copyright
> Add myself as author
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/mailbox/imx-mailbox.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Just squash it with previous update. Usually the copyright is updated
because of introduced work, so keeping it a separate commit does not
make much sense.

Best regards,
Krzysztof
