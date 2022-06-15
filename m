Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CED54D053
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357624AbiFORrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349899AbiFORrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:47:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C442F1147F;
        Wed, 15 Jun 2022 10:47:47 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m24so16323263wrb.10;
        Wed, 15 Jun 2022 10:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=UEplRBRe8Not6/N/87KHMRBTXuTr13tJIbM6hc9f8sQ=;
        b=Px0sxprY8EaTIf37otn4bHLOMuOiouEYqETuqdXAoedA3jFIrkkKeHZvQZcfi6IDQd
         +gPo6UtC+5oE4EUy+jA8XQ7k3lqlL722vCj/oANcJfB4eG3pUwsqRPv0uGe/HecIqW06
         cSNnPJbGMJNoz1TcKBBRCF+5+Gy+Cravzkx4VbGZqli8BcwNbigqDx4TMiTrEehL3wXu
         /D+jaAoPIZIEEgXk+EJBQxt2H4K1b7kI15klNggExGmPBJhVD7tPrtpUq9FphpwM1H+2
         rWMXGX3cud6Dblde43mQIlZpBjDyX+LwEaufSxZUdSU0FK7uOYBP2vVcdz9tV4MoyFOx
         aIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=UEplRBRe8Not6/N/87KHMRBTXuTr13tJIbM6hc9f8sQ=;
        b=XmkHLc8sQbZFr9+YfpUvC5ZH2Hs730EVQDCJXfaC4BlUx8++x44X979WJ4s0TAJEcf
         czsDR6qCe9wnUxjxiDdhLWrNGMjlqo679z46Oa7fM9UHwFa3gTww8JQVgm1G6Itwr+M/
         mdTBlLpMXq8xiCb5BwGgki6EZD1qqzSJhM7JK8V3HrWmZE9H2YLM2bvW/sORDZoc0oig
         lzq1RJLQB3x87/qwijIk/z2JDOltq8t/LJNm2v6yj9rhMpd4wy4efYQAmjhUJgZ20oxo
         pQctcnY0ZKJHdJHqVxWy6nI7KqBOCPVe7ddVTtomtBiFWsRmRgbnQ/aP+IO1APnnsscC
         zddA==
X-Gm-Message-State: AJIora9mYJz6gINCGfT/pH7z/3rHTopUqOAVwAyowjn4IwH/4UHSDIr8
        V/LicxDMldimP+JMyy4OCeFowHQaquU=
X-Google-Smtp-Source: AGRyM1sdCdaiNcC0qqAatgAXTIR/dGxEV0s1FBUtTraV7r7iycMccsJTIVFL8TKmFtDbKNmYjUCrwg==
X-Received: by 2002:a05:6000:1548:b0:217:6480:e65 with SMTP id 8-20020a056000154800b0021764800e65mr934830wry.381.1655315266192;
        Wed, 15 Jun 2022 10:47:46 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id l125-20020a1c2583000000b0039c4d9737f3sm3158157wml.34.2022.06.15.10.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 10:47:45 -0700 (PDT)
Message-ID: <62aa1b41.1c69fb81.95632.5b71@mx.google.com>
X-Google-Original-Message-ID: <YqoOmlGklknRj8Yf@Ansuel-xps.>
Date:   Wed, 15 Jun 2022 18:53:46 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: clock: add pcm reset for ipq806x lcc
References: <20220615163408.30154-1-ansuelsmth@gmail.com>
 <a92fe431-a995-4c7f-b90b-8e80298bc71a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a92fe431-a995-4c7f-b90b-8e80298bc71a@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 10:43:10AM -0700, Krzysztof Kozlowski wrote:
> On 15/06/2022 09:34, Christian 'Ansuel' Marangi wrote:
> > Add pcm reset define for ipq806x lcc.
> > 
> > Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
> To prevent any confusion about identities (we have strict rules about
> these), I need to ask - who uses this email address?
> 
> https://lore.kernel.org/all/?q=ansuelsmth%40gmail.com
> 
> Best regards,
> Krzysztof

Same person. Started using extended name, wanted to do this change from
a long time but all the patch were already pushed so I couldn't change
it since they were already proposed and on the various mailing list.

-- 
	Ansuel
