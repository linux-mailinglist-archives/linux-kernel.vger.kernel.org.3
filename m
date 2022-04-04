Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D749F4F1EF7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376984AbiDDVqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380013AbiDDSkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:40:05 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A366B31376;
        Mon,  4 Apr 2022 11:38:09 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o20so3135012pla.13;
        Mon, 04 Apr 2022 11:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yxHgEHY7w5CfYcKhfNlaSXkW5VQcr12oxx3pPqXpfTQ=;
        b=mJUN0F/hYMo5KhhHAHnesZ6hArDG6Bt5H4Uk0dTAlVjBikhgzrBtG2vp05TuYAmLjl
         2QiU3ddPANmS+K0xGec2VWMf2OA42J9U9A8blGr0w0kKu0WjP/r9zHJSns/YoAn606a5
         8TVppRmmsJoCdiiZlO3Xm48HcxRuamqqHxqZdKpNgWejbjtftqYyLWpL3+3ijblq3w3e
         pGwpek/zURT6SmW36BYZq7mbk+GhM0Fp7Q8VJx26c1/2uKhRn7NaEYuNr1rWEuUTIMWx
         /vQkZngJmt5wXZD8OG+4ARs0BdnTAJZPh31qcPsDUwftDneVbrnDO4LIKmI5RS2uScBf
         6V8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yxHgEHY7w5CfYcKhfNlaSXkW5VQcr12oxx3pPqXpfTQ=;
        b=oLx8NYBCK83JiRp7jfYcUmpR6AaW7xUraGdkdyDj1cSbwnuhxvm6yQrE1nh2Hrkr2o
         oXJpNr8TrmLzTyda25Z9pJA2z/+SIVhpGGqDFf/YOMHG58R1Mrk8urf07dbTW/NfEhWl
         HApIjaSEmS7Dv5zBrCpBzA8h/CVEcFkeTA+Gz3iPoQkFsr8b8mwC/vcoTYb1kpfVilbI
         pczETXvE0J1KLSWsFOH8Qj6NlroBjSagCnL75SFIsKYzn6/gK00sNnXb0IHvkcStFWBw
         a4XkOaLw6NjVNm7I5bRCLNOKUEXE6H4Zkd7qhirolcAuL7mHkVWjOlBpZLEGxKZ1XCZY
         utwA==
X-Gm-Message-State: AOAM530e3gfTeKYXWgQpuEUqBxhiBmpUCYcO2itBdRlnDCvZfTaaH6nR
        K1cUEtJcgpP++Z0jjY8HZTg=
X-Google-Smtp-Source: ABdhPJz2+Q8s2x0+oKPMMGGL4NwhL92R6M0xTPkU2pLT5SLSbtxkS+1FDn3jmNuUDNRbu4HuUHYasg==
X-Received: by 2002:a17:902:b48d:b0:156:7f54:8ffc with SMTP id y13-20020a170902b48d00b001567f548ffcmr1328209plr.95.1649097489157;
        Mon, 04 Apr 2022 11:38:09 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v17-20020a63b951000000b0038644f62aeesm11049383pgo.68.2022.04.04.11.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 11:38:08 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        =?iso-8859-9?b?QXL9bucg3E5BTA==?= <arinc.unal@arinc9.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Rob Herring <robh+dt@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: bcm: create new description for BCM53016
Date:   Mon,  4 Apr 2022 11:38:05 -0700
Message-Id: <20220404183805.2317718-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220402204622.3360-2-arinc.unal@arinc9.com>
References: <20220402204622.3360-1-arinc.unal@arinc9.com> <20220402204622.3360-2-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  2 Apr 2022 23:46:20 +0300, Arınç ÜNAL <arinc.unal@arinc9.com> wrote:
> Create a new description for BCM53016 and move Meraki MR32 under it.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
