Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E145F50D815
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 06:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240901AbiDYELj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 00:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241043AbiDYELQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 00:11:16 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2147847079;
        Sun, 24 Apr 2022 21:07:09 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id p8so13661711pfh.8;
        Sun, 24 Apr 2022 21:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2PdcqZRLrGYWewMO+0J4UfGlrsrMciQWjjDbQSu/atI=;
        b=EBBnLRnNq7Z5wsHox5sLOOntzmOxBw0ws6BNddIbqr3YZlnQRqyeE2X4mgXHolaW9a
         e5n2smsJfQn/e+AFfVVT+Viu81Y6pEPgKRyKmDzJXicpJ5y9wu7VULohoocjkKjPs4JW
         qaJAX4cJ0lm4EYnQJ7U3QvwdL00JWZqM2RAk4dRlteFLR+KSQO4mn0RIdIcjjTLw7Z4n
         D7GAblpdxvPW8qbCz0KqRaGQG367aoZ652lcaj9FOJ7TrIWtZSBnIxLZd0TKcJrb0A+q
         xPeFWdxUFCsz8+txqJQi6fWDhAWVKr6Szor9Mvp2BhOZuq1BBKBCingFn4ZSwu9TVpBX
         gQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2PdcqZRLrGYWewMO+0J4UfGlrsrMciQWjjDbQSu/atI=;
        b=q9bL0H9+vOcEvRQSbIH0hpmIFKlqPg1nNHDHGlnk1dYwcYeb72DvIZkPvYSxHJp6HQ
         bJdKthl54j6EAn0rwAGo5hUCxjdIWYi9t3iki+NBtxTfJhrAKBsGSWZreyU1o1S+rULY
         47CyEwTZCEAQfTUJMrpCSJFMU+s5M0M71gYKovEItoP8i8VQ4X29jsHHnJht/K0723PI
         0b1FQdDkNBS+bFJGuAmxqx5VOogyixu+d0btHL90moCPCFz96+bGA2bAFiFsxxGIEG/Y
         OxVMAeFwsWLJAnfrFpIHRZ5XMszoWff8OOWJ0a3XVTlh4Lphw4U7klcFRNReHOlvXIuv
         UF3A==
X-Gm-Message-State: AOAM531QUFqV4ja9aTphxLdxsakI78l/ylqm35wmjvRSpY4GsQib1anm
        5oxlIKwwa291vzADYdVNpN4=
X-Google-Smtp-Source: ABdhPJwRknQqJGX0YDPXS4AWwTiIghnE0zpK+9PzHIQe+3C7utxudEfznrcplB6ZQkjOwN/CBr9cXQ==
X-Received: by 2002:a63:1543:0:b0:39d:9729:1992 with SMTP id 3-20020a631543000000b0039d97291992mr13614671pgv.155.1650859628502;
        Sun, 24 Apr 2022 21:07:08 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:282a:d50e:e0fc:c145])
        by smtp.gmail.com with ESMTPSA id t15-20020a63b70f000000b00381510608e9sm7848171pgf.14.2022.04.24.21.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 21:07:07 -0700 (PDT)
Date:   Sun, 24 Apr 2022 21:07:04 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     corbet@lwn.net, sre@kernel.org, robh+dt@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/5] input: misc: pm8941-pwrkey: fix error message
Message-ID: <YmYeaGDyJHHr/lk/@google.com>
References: <20220422191239.6271-1-quic_amelende@quicinc.com>
 <20220422191239.6271-3-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422191239.6271-3-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 12:12:40PM -0700, Anjelique Melendez wrote:
> Currently, error message reads "failed to set debounce". However,
> code is attempting to read revision not set debounce. Fix this.
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>

Applied, thank you.

-- 
Dmitry
