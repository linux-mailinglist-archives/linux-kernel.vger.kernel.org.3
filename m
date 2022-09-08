Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB685B2951
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 00:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiIHWah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 18:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIHWaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:30:35 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD9A98368;
        Thu,  8 Sep 2022 15:30:31 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id v1so78480plo.9;
        Thu, 08 Sep 2022 15:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=owRTZNGDqD8OkXSsM5EZ0PBzmfLvZiHCsKH36J3GWzE=;
        b=IW5wfUNojOUdLksrhQ8M1jLaDtbvk0JEhw/CbA0gvUsmftc9A/Grf5XNs/HPYMAfS1
         uzbfEOerhMV6bc1STzE00vVlmTA69Tp4J4GNmPH7LeAQjAD4dIk3O1I8YLRssPGBJJ4P
         NeuOakTfVaLpxnuRLct7k6ut/m1PA9eBFXchie5mDWeceBRobPy1Opn4iLGX30+Oyrvf
         X0h4t4yP1aD2cuaWQJQQKDH416C7349dm6EZ6W/Gsz/7uoCGnJx6aUVTEY1PThkxpMuC
         mWNvrFi2Z6nZ3cQwfs8b6RfNajkPNzoFbqdZXdVgTFcLLUyFo0lOqRc21SS6i3THrGyW
         c5VA==
X-Gm-Message-State: ACgBeo2zl5lVSRUrWSOQul8+hcbNeAnI9o2nQKM0MKXXWGjF/XTEq+Eq
        1wMNfNyguJ+woICFU4tYX3A=
X-Google-Smtp-Source: AA6agR4AmdI6ANzSvSg1QHamHjGKyR0vgTuxKkPqN8q60s3wZZMMIHAj845AlqJX3oSCxLYcNzsYjQ==
X-Received: by 2002:a17:902:850a:b0:176:72af:65c1 with SMTP id bj10-20020a170902850a00b0017672af65c1mr11040922plb.81.1662676230853;
        Thu, 08 Sep 2022 15:30:30 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:c18a:7410:112c:aa7c? ([2620:15c:211:201:c18a:7410:112c:aa7c])
        by smtp.gmail.com with ESMTPSA id q1-20020a17090a7a8100b001faf7a88138sm60776pjf.42.2022.09.08.15.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 15:30:30 -0700 (PDT)
Message-ID: <3ea54f9b-896d-c70b-9024-4dc4f99ec2d4@acm.org>
Date:   Thu, 8 Sep 2022 15:30:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH v3 4/4] ufs: host: qcom: Add MCQ support
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, avri.altman@wdc.com, mani@kernel.org,
        quic_cang@quicinc.com, beanhuo@micron.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1662157846.git.quic_asutoshd@quicinc.com>
 <260533ec3a80442b73d3999727bf0a9861462eba.1662157846.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <260533ec3a80442b73d3999727bf0a9861462eba.1662157846.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/22 15:41, Asutosh Das wrote:
> +static int ufs_qcom_get_hba_mac(struct ufs_hba *hba)
> +{
> +	return MAX_SUPP_MAC;
> +}

The above implementation is not sufficient to convince me that the 
get_hba_mac vop is useful. Please remove this vop and use MAX_SUPP_MAC 
directly where ufshcd_mcq_vops_get_hba_mac() is called.

Thanks,

Bart.
