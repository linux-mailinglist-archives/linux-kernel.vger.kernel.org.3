Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37F558A9BB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 12:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240566AbiHEKvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 06:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240392AbiHEKvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 06:51:48 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B951AF22
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 03:51:43 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso3750067wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 03:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=14I21r/C2T5gj5MFV9rNnjq+AZGCTtTGTud4uPILJ6o=;
        b=odqbUrp/6t9+aD0+zZPOFFfmmSgvMJuRVpCRk1PePuU926IozOvJ9NdK+sfmVufOwa
         cQ23Nq4buCcvGH01u/QXbURGoNPYopJay4P7KBTh5+BInjeMltMAEJjMUai43c+inrra
         GQeQjZlftth6fdytyMnNvqTolLDelT1WbR1JMpMnvuL7PHeBpjVNyj31XHq+r6oIry0J
         z3o+HI34em56UVc480k88EhM55KKAq/+ZTVM5pxGr84XN3hzEkvpZhjL1ZQMP5++Jlps
         da1eZXsOtzRCfrXbUDuSFoSg24KASv+u6Rz98idPFTCl38uSLihWfsAimQjyOZ8yG9d+
         e6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=14I21r/C2T5gj5MFV9rNnjq+AZGCTtTGTud4uPILJ6o=;
        b=ZEFk4e/v9hTg2ydOBI36Bqf/EpyO2iDy29qB2mcs2HNYHC+SyW+FBb25LkoN34QNjn
         SAkBJRplTSimMSwGR+ik1bcLIV6k+Vxt3hxfSgIbJKjmAQnG/ZK0ijwM6QCTmsa+22Qh
         pccUeQEXswpDRoU8enr1+dGDtv1AijhKpDvnH1Qz+8WRqGFhBwgJWmcDz3D7rwknuGGr
         AI8N9kSC4OGGr64bHpmFkDTH0x4yOX19Zwql1wNooGj+xAkZrywuXnmjFlgu9M4ftAi4
         Q3rWh5CL3u/QfzImONqWtp8Ze8zuLfcJlPNp/jHkLFhhslC81Pvri3oI6p3eoKrnL+um
         9miA==
X-Gm-Message-State: ACgBeo1sKo3ymgDr6mjWjfARc4xWOqPBnGdDrlR1jNqDtjUdbbNKisr5
        JZXuRT2EXftFna3RquZotT4fAg==
X-Google-Smtp-Source: AA6agR7IVfW6BEm1e5JyH456NjFhWR6xebJRTIYxwMXOLXJdc09b9LQRA5oZOMRai6bfYr4f/zWXIw==
X-Received: by 2002:a05:600c:35ce:b0:3a3:1b7f:bbd8 with SMTP id r14-20020a05600c35ce00b003a31b7fbbd8mr4150961wmq.22.1659696702015;
        Fri, 05 Aug 2022 03:51:42 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c4f9200b003a504f9fcefsm4220988wmq.11.2022.08.05.03.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 03:51:41 -0700 (PDT)
Date:   Fri, 5 Aug 2022 11:51:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH V15 6/9] mfd: pm8008: Use i2c_new_dummy_device() API
Message-ID: <Yuz2O+lZ5W7RviuA@google.com>
References: <Yr6oLlmfWRkiAZG7@google.com>
 <52c6ab15-1cd8-324e-4bcc-c449d8bceb19@quicinc.com>
 <Yr66ZZqEnBApHYMA@google.com>
 <0481d3cc-4bb9-4969-0232-76ba57ff260d@quicinc.com>
 <YsLhxx+L3+GJDRyO@google.com>
 <bcc5f059-b991-296a-bba6-9cb1236097f2@quicinc.com>
 <Ys1tYAO39LKzEAOE@google.com>
 <dc737abb-041b-491a-14f1-a584f9e64a3d@quicinc.com>
 <CAE-0n528QaTtZFp=WAaHShegFRpKVN_67jQfUJTtsRPr6s--zA@mail.gmail.com>
 <52039cd1-4390-7abb-d296-0eb7ac0c3b15@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52039cd1-4390-7abb-d296-0eb7ac0c3b15@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Aug 2022, Satya Priya Kakitapalli (Temp) wrote:

> 
> On 7/27/2022 6:49 AM, Stephen Boyd wrote:
> > Quoting Satya Priya Kakitapalli (Temp) (2022-07-21 23:31:16)
> > >               regulator-name = "pm8008_l6";
> > >           };
> > > 
> > >           pm8008_l7: ldo7@4600 {
> > >               reg = <0x4600>;
> > >               regulator-name = "pm8008_l7";
> > >           };
> > >       };
> > > };
> > > 
> > > 
> > > Stephen/Mark, Please do let me know if you are OK with this design.
> > > 
> > I was happy with the previous version of the DT node. That had one node
> > for the "pm8008 chip", which is important because it really is one
> > package. Why isn't that possible to implement and also register i2c
> > devices on the i2c bus for the second address?

If devices have different addresses, they should have their own nodes, no?

> If we add everything under single DT node i.e., 0x8 device, then, we have to
> use i2c_new_dummy_device() to register 0x9 device, and pass regmap etc to
> child(which Lee is not OK with). Even if I register the regulators as i2c
> devices, I am not sure how we can retrieve the 0x9 regmap in the LDO probe,
> because when I use dev->parent there, it refers to 0x8, as I am adding
> everything under 0x8.
> 
> 
> To implement what Lee suggested here [1], I will have to add two devices
> separately in the DT.
> 
> [V15,6/9] mfd: pm8008: Use i2c_new_dummy_device() API - Patchwork
> (kernel.org) <https://patchwork.kernel.org/project/linux-arm-msm/patch/1655200111-18357-7-git-send-email-quic_c_skakit@quicinc.com/#24933901>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
