Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A067B50A26F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389378AbiDUOba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389350AbiDUOaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:30:24 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E633DA72
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:27:32 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id b188so5737460oia.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y+YeVpF+XXNXv6igumvGpGrAaQhmDe2XduTo8xGKCNM=;
        b=Xi2WxW6CvV2f6mBJr9C2k7VR0F64eAH9Ts8vrRc0czw4dlLBaNEPvimjsGsQvuivb/
         v1bs5ZqhhY1vPHHBS3XieOmtvYrhNaDep9OFdHgfOeiK6eQdOc2dBbPHcEFV4K0UmjCW
         sVHpy12E8ZT8+CjjRNdOz/3jvo00AASP3Qa5SJ0FNCnvSoZWFx+P8wBfWMegahrerfii
         fm1z6tO1eNA2VhlUQmPYgesQQsNicvjjTgx3Jr0QYEbCMkuBOTGYsV9+qxkaPelI8Ktv
         IsVqZMlNB+JgTB0ZbfwB1foUk5xtCaebqgk7egEY0x4hiK/ENSfjUp9lKIXDkiTgJuIf
         tkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y+YeVpF+XXNXv6igumvGpGrAaQhmDe2XduTo8xGKCNM=;
        b=nahInhw17t8ox89hT+SipVyT9CtRMOpToEIQ+qDFqdBMKC/JGGcheC9GosONjrBEp4
         rK7zOR8W3GdKer6Ho18dEuiN4OVVtMwX1znMUiEaJ3cVMvmMH4i+I3uEFWMnlI9L0bNB
         jZALbs7jaVLTrU5WFe6/HejACJOAgXa5/sEqQpyTMgMYkRJ0Ukdmy1eXc1Ja6MmKal4c
         2kXgVpkKXKhjxVdQVoB7KNoChKf8DiXcvR9+71vs7DWk41aZXwYr9l0Hfa4TIwPO530C
         irHf49VALKQUXHSIGgK6bTBtxA/57j7XTWDSwqtGZ6vzMCzyezYLWuKnozS8H8xojthl
         vnpg==
X-Gm-Message-State: AOAM532gB0JS+BOrHxbIKy+psSuqjufTzeAkdBPJSwz33J1GWrs85iql
        Xt7fyqZ/CvkIAJ7GakzauvguZw==
X-Google-Smtp-Source: ABdhPJyAWDnEf73EJQ2xtQ/tjqK8JJQHB26dASCBxTB3qthtJ1S/h5Slz6yOHwSC2UdCbKFEyqqrNg==
X-Received: by 2002:aca:b505:0:b0:322:a524:8859 with SMTP id e5-20020acab505000000b00322a5248859mr4133243oif.2.1650551252015;
        Thu, 21 Apr 2022 07:27:32 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id s14-20020a0568302a8e00b006054e841915sm4296295otu.73.2022.04.21.07.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:27:31 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mukesh Savaliya <msavaliy@codeaurora.org>,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v2 4/4] dt-bindings: qcom: geni-se: Update UART schema reference
Date:   Thu, 21 Apr 2022 09:27:07 -0500
Message-Id: <165055095990.2574292.9008815958206587881.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220404182938.29492-5-singh.kuldeep87k@gmail.com>
References: <20220404182938.29492-1-singh.kuldeep87k@gmail.com> <20220404182938.29492-5-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2022 23:59:37 +0530, Kuldeep Singh wrote:
> We now have geni based QUP UART controller individual binding, update
> reference in parent schema and remove properties from common wrapper.
> 
> With removal of last child node schema, remove common properties of all
> the controllers as they have become obsolete now.
> 
> 
> [...]

Applied, thanks!

[4/4] dt-bindings: qcom: geni-se: Update UART schema reference
      commit: 6579f39290bf056442850094b8f4b95163c17996

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
