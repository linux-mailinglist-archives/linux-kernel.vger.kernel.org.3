Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D93D55D085
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241019AbiF0UEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240872AbiF0UDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:03:40 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71CA1CB09
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:03:38 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-101dc639636so14321361fac.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jvgva+U5lOkOQSQ8o/MkPVmb6ubeotEvTIdrvmbwNXw=;
        b=nFg4oJhbvz29tnQuaniRFS6ine4Uq12NheA8tf/FMRwolsQ2mwhZZkhGtjkvE/YwbI
         n40tG3Dx7t8BWwG3xgyaGd0A4zjKOkSkXJOkYZmIxeNobDb+AL/qJmMD0EoALsQFkevo
         4l7k1lAOte9I814++tA/Fg6YW8wfPwr5A34sccXWoAr3ggy0b3w7PUeE7tUh+ovhkhVf
         2LPwKFlU3YoNJDvRereUEkHdXyYPTxaSztoyxz2yP7tP0dqGt0dvZoegoGdh7JSf0UeJ
         8RFNApvfLTWB8jh5vzvUhjKog83oTYkBtt1Tij6nxt/BvlnPfEKYhocRNJGX0Rph8ZeW
         dK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jvgva+U5lOkOQSQ8o/MkPVmb6ubeotEvTIdrvmbwNXw=;
        b=sp16wsiVg7NCL/JnXGiDzVk4+vCm/kluj9bb59JqWcH0K1inkqmpA2oolUG+iIPEFC
         2MwgA7WQeQsNEedMFAResL8De/CixZ7iOdHqO5LXRbs6WMBqB/qcMmzzDec5q5P8WTHR
         cqXbZssF5nCaEp8SCljhhOnACS/8dyJVZXobfxv+eHiVIuAaxghRVLFqTbZCv3MaIl7s
         C+nZt+9T6Odmne1mi0HpnZqskSOBJFlbNqOAzI9I0T82NHrQK6YDhaYxOTo7fO7PvQjh
         yimUEWrbkA6DgDC6UTKks+b3bcWGkFANRIQ+tPP0M5WIuAE1w8bQZJX/dDC+YG7VtPvT
         0pOw==
X-Gm-Message-State: AJIora8A9ETTyXg+JQ9ZQ/dg8CDuEix9faH6g0hErJqzjHbfAdCjh+t4
        gEKQi+oKE9Q2FH5aGNgG4VidgHx4diQ0rQ==
X-Google-Smtp-Source: AGRyM1upJIWlC1b7QEhyBnYE383v35bmMMHh8lIytRSBhiMsVKreGsp5xlgq1wnpbefcT732dJZv7Q==
X-Received: by 2002:a05:6870:41c9:b0:102:820:ac9e with SMTP id z9-20020a05687041c900b001020820ac9emr11246624oac.167.1656360217793;
        Mon, 27 Jun 2022 13:03:37 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m16-20020a4a9510000000b0041bdf977c6dsm6428729ooi.31.2022.06.27.13.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:03:37 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 1/2] soc: qcom: cmd-db: replace strncpy() with strscpy_pad()
Date:   Mon, 27 Jun 2022 15:02:55 -0500
Message-Id: <165636016349.3080661.4448444375328964052.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220519073301.7072-1-krzysztof.kozlowski@linaro.org>
References: <20220519073301.7072-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2022 09:33:00 +0200, Krzysztof Kozlowski wrote:
> The use of strncpy() is considered deprecated for NUL-terminated
> strings[1].  Replace strncpy() with strscpy_pad(), to keep existing
> pad-behavior of strncpy.  This fixes W=1 warning:
> 
>   drivers/soc/qcom/cmd-db.c: In function ‘cmd_db_get_header.part.0’:
>   drivers/soc/qcom/cmd-db.c:151:9: warning: ‘strncpy’ specified bound 8 equals destination size [-Wstringop-truncation]
>     151 |         strncpy(query, id, sizeof(query));
> 
> [...]

Applied, thanks!

[1/2] soc: qcom: cmd-db: replace strncpy() with strscpy_pad()
      commit: ac0126a0173531d91d164e244ed1ebbee64bcd54
[2/2] soc: qcom: correct kerneldoc
      commit: d11a34a404ee5565ce8e0abe3e2b9ce6f5cc0a4b

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
