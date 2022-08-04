Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A49B58A1AA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 22:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbiHDUAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 16:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbiHDUAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 16:00:39 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2543C65815
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 13:00:38 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id iw1so788389plb.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 13:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uPKzNE7zSTqAILSSyuQ5RS5DAOTT4hKdjbxnUqUAfI4=;
        b=I0H9xhAFu8B0PsZ2wzzp9dtRhFmaNDy2JgRcar6ZmKjHC/c5ykMQ8R40A5dsr2y0/B
         V2x0ZFDTcqJvx0FgcTPvj7uCgEvLEg80RKdgaL6hDHSSlnD2dhNgXezAdxki/NMJQcXt
         i52PCJT3NtE8YdPWCZWd2C6QsxqTzIEDIItv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uPKzNE7zSTqAILSSyuQ5RS5DAOTT4hKdjbxnUqUAfI4=;
        b=ki0+ANzhspPpvitpcCefOBR1Whye6sGOICbwIU4gtvdeVg28rAvwMIfCXF2K+j6iX3
         Bc18+XMxwZ57YPfjmO09MKCuzIba4Jcsb4auX5/PzI+irgmF6FEQw1DOYeZMZzhScvZu
         h6OoGmZnpRjpd/PE8EWZCxVsgpNxvZ5qqo7clmUd257GO8EPUM51B/+e0PZ4dIJ+XTTJ
         JE0tpmnJs5vD0pAYzLVP/hWUtm8qKrcspq1TG4iAJ6OvBJfHu4F8fOzB13xz9stRzjAe
         l0/AwjkH6WfQl8eAkJCKh8Glb7ugZpNjoH1Cikc9W+nBVPNAi2lxsp3aVLXTsys8sknb
         LH+w==
X-Gm-Message-State: ACgBeo16TCbN6AkvAoVMUFvul5E7/NQE9SLXzUDxWgjWEnaIv8AhsnQ/
        bIjo7XwD9WzbId97cXepbpAlgw==
X-Google-Smtp-Source: AA6agR7XAhmDcGQM/wvX7qqgr70EsoFmAqGZ++uJh7cLd6Ebn25QM1du7Mx7NuF3B2s4Oa4Axp1WrA==
X-Received: by 2002:a17:902:ce8c:b0:16c:4be6:254d with SMTP id f12-20020a170902ce8c00b0016c4be6254dmr3306258plg.51.1659643237649;
        Thu, 04 Aug 2022 13:00:37 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:87c4:32ca:84b6:e942])
        by smtp.gmail.com with UTF8SMTPSA id z5-20020aa79e45000000b0051bc5f4df1csm1364362pfq.154.2022.08.04.13.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 13:00:37 -0700 (PDT)
Date:   Thu, 4 Aug 2022 13:00:34 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/9] usb: dwc3: qcom: fix runtime PM wakeup
Message-ID: <YuwlYh7b1oBoMuBT@google.com>
References: <20220804151001.23612-1-johan+linaro@kernel.org>
 <20220804151001.23612-6-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220804151001.23612-6-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 05:09:57PM +0200, Johan Hovold wrote:
> A device must enable wakeups during runtime suspend regardless of
> whether it is capable and allowed to wake the system up from system
> suspend.
> 
> Fixes: 2664deb09306 ("usb: dwc3: qcom: Honor wakeup enabled/disabled state")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
