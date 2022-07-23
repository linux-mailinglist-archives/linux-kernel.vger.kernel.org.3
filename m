Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05F757F001
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 17:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbiGWPQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 11:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbiGWPQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 11:16:34 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A051116C
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 08:16:33 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id r24so5398502qtx.6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 08:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1YtoaxKMgqFbgqvJGmE9UgUWogTVn2ODlS5NDKP18O4=;
        b=l70Mjul+h5Radj6oYylQbwVHGY3QUu7zaSKdRfgIGh0bM0TzCyjqOhUar6wHErd6EX
         t5Bm0eJw4hItL8gAg+3Z12HnzpdvlWWBJ+84BbqL+VxgCpMq4rLb7uA4PUPeABcOX3CN
         yiXg8uBQzgmRLG8m7/c5+XCPbIJDEBv+OkDC+peI5Gze3/5JN9ORxzhaP9/d0XInj+No
         vrjxrQuwX3nv97nExdt+/UfxJycoa69OoiQNamE7+6nTQeuunvFHMk2+D4uL4rg8NQDk
         4UxLEdNBHUsZz3K2MXZbFW3/mwWmWrs36Axtnc3iKq/0AO6xTeDxiYArdfmzwroYFE79
         MIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1YtoaxKMgqFbgqvJGmE9UgUWogTVn2ODlS5NDKP18O4=;
        b=1i5ZcXgAR6hG2UXg0NGTN3x4XhdTN5P2yL3I+csPN/ZqIZCgyYG38nwGsF5E7wd2BN
         hcIjUYpSThxRry6W9NIo7972PMTeLmjY7a4JFHqL7SdXlQFaMdQjTben0Um6Zf1G0pI9
         jIPKGmYX/4nCkOnz1bUr8kJJ32XCdR8KtuXeh/uz3/jhe0oXfb40JcgO4l5KUY0IAR4o
         iGRetfRWXE3oL5yspEgnIFRIa2PfRC43sJifw4Uai3DoPJYIKp/AmrXYGqV76Zj0eEIY
         TYrn0OzugFf3aStaxerO3W41CNvjZ7OLLSREEHemmAFuiQErKoo24nE+Yi5wdqL/nG1H
         gRXw==
X-Gm-Message-State: AJIora+ojf0vTmuF0BK2KAAlRC5KoFHpNKACuQwoHNq8h4LuEkRRXHey
        6uLjw6diUNku7cNGiYwmzx+ErV53ugEIKgaXLtkByg==
X-Google-Smtp-Source: AGRyM1vf2WiEVwlCT9YnJ6xSz8XxbYlaFhc+nO7qQld2E/tiZpgFlxDUCYVy3R1USbP9Fxb0o+uxaD6jJVvwa2mVA/Q=
X-Received: by 2002:a05:622a:178a:b0:31e:f9ff:c685 with SMTP id
 s10-20020a05622a178a00b0031ef9ffc685mr4423061qtk.62.1658589393102; Sat, 23
 Jul 2022 08:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220723145558.25210-1-ansuelsmth@gmail.com> <20220723145558.25210-4-ansuelsmth@gmail.com>
In-Reply-To: <20220723145558.25210-4-ansuelsmth@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 23 Jul 2022 18:16:22 +0300
Message-ID: <CAA8EJpq+Ovuz3zht+=2KKmXE3gB55JidAYEs8dsSNZiggmA5=g@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] clk: qcom: lcc-ipq806x: use ARRAY_SIZE for num_parents
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jul 2022 at 17:56, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Use ARRAY_SIZE for num_parents instead of raw number to prevent any
> confusion/mistake.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
