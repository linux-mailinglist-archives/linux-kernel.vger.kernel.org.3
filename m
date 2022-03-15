Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772074D98E7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347088AbiCOKiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbiCOKiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:38:02 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AC64504B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:36:50 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 98B053F366
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647340609;
        bh=TEi9FBbJRZ98ujLdP/Lz9ClVk8P7w5er1AYT1Hftf6A=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=MfwiNKli0xUAvhwoAWkyB2P22xn0Zd7WiLuT0f2DBv7yZ8vKvUNMocqO4NypKd/m2
         KhaE/vtty+f/XTK/lSBBdUD7HaiES2sdJewEY5l00TQXlcUEM/xic2KhdbL30/LHn4
         iV/0oQHUMONKcY8WE4nFDbMKyGazxcjiPdiyLDuKRBW7rir7JUWc91jiRobP6FiClR
         7L1Qw7eC7upNWlhP+NBZ04Y/raoHHfbnK2J4puxvlT9w7VYIQxkH9UE1qqBNiB6xNs
         8lWK5+zQjH0qdZrLucovfpuHZqvmBkHrryebCZ8KKGA9/KT5sDkAN3cDOnA62szP+D
         Grc+77YMKCLlg==
Received: by mail-ej1-f70.google.com with SMTP id y5-20020a1709060a8500b006da9258a34cso9424207ejf.21
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TEi9FBbJRZ98ujLdP/Lz9ClVk8P7w5er1AYT1Hftf6A=;
        b=7l+532FWQVueGehICdgunmYvrbJKEGU5X5fWlKeWcSO0Le/f6Qb6AQlmF9oZ2Ea5Sy
         6zQqikIbh6mXlLptUrTeOzitwwy3q5F1mHzLmwr3NznJ+Q3qZi1xJWIXKAzKf/nZdYmf
         r+DWXiYUOVWW/9aLfpw/u2N/kuqo3GejWtyJsX2UAyb3NzVgCJvynUkG1C/DKCS4MarG
         9SuiYNqSJmtOkQBn7OpmuyjB0qpW1udJiweVeTSJ40/l2v5okhgGMCU7flAbXxkPcOLu
         DNkf65+gYXCdxMf1W6d0jUsRcOFLdQa6fIJR1vI/fuwR2OHc3TvppSCfMZ05XrLof6jL
         JxiQ==
X-Gm-Message-State: AOAM530HsvgyKRLhitxQousRBWEPTw6nGWGmgeGdn8uTcmqATSWjy+hH
        8xuHRICsyBDcsI+pCOPVdM0qLXXowoozkuL4Fy/lCzg+dRlX+FpGvPcnVyYiUmyJp8ej0izWXFf
        Hrut7l5bFUFCFc/+sWohvPbTTEh07tua9jYJW1gK54g==
X-Received: by 2002:aa7:d295:0:b0:416:438e:d9c4 with SMTP id w21-20020aa7d295000000b00416438ed9c4mr25157405edq.98.1647340609086;
        Tue, 15 Mar 2022 03:36:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNAdezzJXlvUWpVXxB4T7w7pvN/7+3r1jrwVFjSzPbTqD5zxBdf5ZWDjZyxsdEDeC/bjygzg==
X-Received: by 2002:aa7:d295:0:b0:416:438e:d9c4 with SMTP id w21-20020aa7d295000000b00416438ed9c4mr25157391edq.98.1647340608923;
        Tue, 15 Mar 2022 03:36:48 -0700 (PDT)
Received: from [192.168.0.155] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id o3-20020a17090637c300b006d8631b2935sm7869716ejc.186.2022.03.15.03.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 03:36:48 -0700 (PDT)
Message-ID: <bcda63b6-16cd-6514-42e7-fe09f5a5fb34@canonical.com>
Date:   Tue, 15 Mar 2022 11:36:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/3] dt-bindings: edac: nuvoton: add NPCM memory
 controller
Content-Language: en-US
To:     Medad CChien <medadyoung@gmail.com>, rric@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, mchehab@kernel.org,
        bp@alien8.de, robh+dt@kernel.org, benjaminfair@google.com,
        yuenn@google.com, venture@google.com, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING@nuvoton.com,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        ctcchien@nuvoton.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20220315055504.27671-1-ctcchien@nuvoton.com>
 <20220315055504.27671-3-ctcchien@nuvoton.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220315055504.27671-3-ctcchien@nuvoton.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2022 06:55, Medad CChien wrote:
> Added device tree binding documentation for Nuvoton BMC
> NPCM memory controller.
> 
> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> ---
>  .../edac/nuvoton,npcm-memory-controller.yaml  | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
