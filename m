Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CF250D166
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 13:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239222AbiDXLH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 07:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiDXLHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 07:07:54 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C81B3A738;
        Sun, 24 Apr 2022 04:04:52 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id be20so7013603edb.12;
        Sun, 24 Apr 2022 04:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=6LLXdUdwxKY7YdYKPcEjKt1YLzULEQ9fvuAEvpfSSVc=;
        b=bxNilV/G0uGLePf9NmRaDFUR61yh2eOu7FZQvxpN8b3X1AM61Fk0PO2AcYlBGwJehj
         3uCp8M9O7edZD86EuS/IWyMg+HTIoBKNxmQ9sbiuRYhjAL+8EdRSxRUjYRiljQtbu4Ao
         HttIEC+WmpeBMA+h3c5YYqfFqdnMwd4PsMmWoApVXjAQtBMO1yORAaMWxmJMnqyHYdpV
         DV3SiXsq2KlWb2jVKkPIkfh12sxCT+1Rw55XZueDUUIzqRVdTDzlKENVBa5B751ybPMF
         Ad/a53WSqFv7TQgN6QAPVi/QE8T3g2kQGXCT6qz/+1sqmzc+qD+IOFarxdVsSWMF2FW1
         d26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=6LLXdUdwxKY7YdYKPcEjKt1YLzULEQ9fvuAEvpfSSVc=;
        b=hRopNf+lHY2heABORPga+UwvPu5gtBbTQSDcpH8nKyXCz72Hft8DZQ5gYJY7GmjQ9C
         iUo9jtN56rsZDk/jSxTm9aTBeptwAZfKqR0rVrZODPssmgovu4QESIFNuDK+apzdZ/w8
         SAUG3z35D7rWwRbFX2qYg++sCxUO1/6cpE9B7cesmCymo+MRsZs0RSrESuUM7OEfWd1V
         foCjzWg/UNFnWxpVVfXRrERL/3qvwOey7WupBhLLUGxVA/cVwjlXR8Nz8+qVlqK/bfgY
         +4yv0Hj5fgSg2ekrjoA98UD24gTuF1xSxRAysr88aXxsH7geGwT1e6i5V7tBdf/CTf/3
         45eg==
X-Gm-Message-State: AOAM5327E+Zp42AOmmxniXvZFTwxeeXFnHkOl9gnqdqSdngE1I6gRHwY
        dv3GV1uIWNwGGhxObrakquKwDX6OVitRiQ==
X-Google-Smtp-Source: ABdhPJzvsh1P684P9PR9vpiWSWqxY0VwT4x9TksJZZ/owoajUzP2VckOsExGoo/ZDHniBzKR8D5zDg==
X-Received: by 2002:aa7:c790:0:b0:41d:7e0f:f15c with SMTP id n16-20020aa7c790000000b0041d7e0ff15cmr13626785eds.129.1650798290974;
        Sun, 24 Apr 2022 04:04:50 -0700 (PDT)
Received: from [192.168.3.2] (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.googlemail.com with ESMTPSA id h8-20020a1709066d8800b006e09a49a713sm2499580ejt.159.2022.04.24.04.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 04:04:50 -0700 (PDT)
Message-ID: <0b8ffa449b2ff56d994978ce73e0c9df0454ae07.camel@gmail.com>
Subject: Re: [PATCH v2 4/5] scsi: ufs: core: Remove redundant wmb() in
 ufshcd_send_command()
From:   Bean Huo <huobean@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     avri.altman@wdc.com, alim.akhtar@samsung.com,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, ahalaney@redhat.com
Date:   Sun, 24 Apr 2022 13:04:50 +0200
In-Reply-To: <20220423140245.394092-5-manivannan.sadhasivam@linaro.org>
References: <20220423140245.394092-1-manivannan.sadhasivam@linaro.org>
         <20220423140245.394092-5-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
User-Agent: Evolution 3.44.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Acked-by: Bean Huo <beanhuo@micron.com>
