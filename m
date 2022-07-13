Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CB8573422
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbiGMK1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiGMK1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:27:33 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D585EFACBE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:27:32 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u15so2035516lji.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IBeghQjIQTuVAuHODHdWbCnnEDL7Ey8qKJa2W4GbzSA=;
        b=iw5lmfXnsjKcqo/hUQUO2lquCgD6f8aijivBEOcwB6PzEBfK9W/aE3o/QYed5UG9Jn
         1Zm03K+xmeq5/UnebMPAoQedLnM+xrSf+N0MLn3UgTR7M+dBUWp83gA8v7CaPjlgTtJK
         JdnsXqQ7eIObYLW77c9T52FgbsVFS+orz/3qVLCBIIQG9dTFnPB+7WQbesJ5AuBpzz44
         VP9BLim6acCvFrA1bV0A/KFypN3eQwFLD+0oIwN1ag0JATZ/9lNHT4fp2dGs0UYNXnn/
         obuqKG6kLHTCAjHQC0aKOe8NtQx4jGmLcaxP3+SrxKBgXptRs0tCqnIYhIW363WsWEPg
         IPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IBeghQjIQTuVAuHODHdWbCnnEDL7Ey8qKJa2W4GbzSA=;
        b=eZZ0YJ7HstrtZ4u3wRuBpDCt177Phh8l5bNl/0QKZWBSYRcH4ouYfZ/UmWUJiL9hda
         sFxwYgZPW5ndFqDXBlmrcshPg6v6Dyk8ofA8uM+w0c797gMu6MAIO8NVv5MUkY9AVJvO
         oa/8ru5dT2U0TuLApjelt2m87SuSfMSPLzGZBkLke72Vr6Bg5WHfXT3uyzK4aQKAuA+7
         m4qxEYtz2r/dGgKB1kXToGMqbrN7zNw+xuwVuUseL7lKPoCsSJfvCFr28hLlEvVeqHri
         It4NrYJUkDanXxswzmn1q+ocTYl/Q1aTOsAUTUSa4gl29sVzgPhNGiVmHKidST7h4/Oq
         udCg==
X-Gm-Message-State: AJIora8FDUPXUGOPq2mREs8KnNfzEoHdnHsZ4fgWj7JjZSA99eKXbAFR
        0gbuFySdOntY9544om+W0aU=
X-Google-Smtp-Source: AGRyM1tAkNAlsoqfiJCsQ4j3Cu4MlpJnLmrn7ZCjD2jTjwvjXMdDmcY1ofTiDagYlZ/nIy1ptpT1Ww==
X-Received: by 2002:a05:651c:4c7:b0:25d:8797:cd4b with SMTP id e7-20020a05651c04c700b0025d8797cd4bmr1327409lji.253.1657708051176;
        Wed, 13 Jul 2022 03:27:31 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.63])
        by smtp.gmail.com with ESMTPSA id b15-20020a05651c032f00b0025d652e12c5sm2583780ljp.109.2022.07.13.03.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 03:27:30 -0700 (PDT)
Message-ID: <437bb094-0768-47ff-fd36-9f181feefe6b@gmail.com>
Date:   Wed, 13 Jul 2022 13:27:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] staging: r8188eu: fall back to random mac address
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
References: <20220713075552.140927-1-martin@kaiser.cx>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220713075552.140927-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Martin Kaiser <martin@kaiser.cx> says:
> Call eth_random_addr to generate a random mac address if we cannot load
> the mac address from the efuses.
> 
> Do not use a constant mac address as fallback. This may create conflicts
> if we have several r8188eu devices on the network.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---

Looks OK to me, thanks

Reviewed-by: Pavel Skripkin <paskripkin@gmail.com>





Thanks,
--Pavel Skripkin
