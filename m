Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35C85844CF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 19:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiG1RSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiG1RSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:18:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57EB6D2F9;
        Thu, 28 Jul 2022 10:18:03 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d8so3101591wrp.6;
        Thu, 28 Jul 2022 10:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=i3paQ61o/yx4mIpYbgKE7SfRYIEBKuTWW5iyIQujhQs=;
        b=nVfPb+j5UmAyaN0hkyu5VgYlapK5eMWr54mFEuLsqvdKXguhReC2om7eqVy2hv/Ttk
         xhCm57Jnn3FCz3W6hBKtyZvo4az36ChihngxtWd8Z9iwqt4qFmZct4iQ8U9UcIP8ltX4
         zOSOVlAQGe+0s+RTSA+juIeT36AjZarbjYJP4hp6kZ9KcfigaUctVwgXvnuvvOBpa7Lw
         Pgaib+3B6v0QsoIuZhPBCtt5RQ8RfGkohtSD26Szb0xNn9IKHScGFG4A2h9kqGNR8Vu9
         +Vw/xJwDem+RVXTDFqGiwl6F70mvysI/CzfY7V1NJqkdNnPpxnJCF3wiV6HKdiXmNYSU
         7zMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=i3paQ61o/yx4mIpYbgKE7SfRYIEBKuTWW5iyIQujhQs=;
        b=Aw7c5nXeXRHdHA+RTXlC84m7RbEmIDU6sP36QIYES5fREo/939N+A61mzXQLriv4eh
         kZSW1bvKU0Nb+yTy+fYlfcdGdsAoEoNKalw8dzS7S+AxhW2LvWJ2ouh5YgKrM04Ybd/s
         LCtMJES6RqZdeGhxAwinmKmpXF+P5+cacmW5KBO6KcX4YgE5L8mKyfX6Xp85+GQ93sF5
         rCxl7lrIfAJQHMT3K6zT0SbqfY924YFtnapC0HqN0JnDspGHYzDC3LHmkrCCNFfQfXmI
         WZL1lLt8H4WhDz9CnxtJ1XBSyOmtSR5RXaqF8V9RHxGwWbloE3wJbq0st3FQ1CyhkPJ7
         RYgw==
X-Gm-Message-State: AJIora8+HkWqlwsU1x32AR4W1txJCJhl+IutXcX0n9gWOG3tBr7e55jO
        RkoII3o43RQtZAPlF0YhmfjOdzewKdE4qw==
X-Google-Smtp-Source: AGRyM1t/V4qQvwEljxEh8I0J0FjVXH4YBqy7FTjUGMzKMO9KKVBLLGtcjQBHc+FdXaAsdnVPtdH2+w==
X-Received: by 2002:adf:f1c3:0:b0:21f:452:8595 with SMTP id z3-20020adff1c3000000b0021f04528595mr2260650wro.530.1659028682316;
        Thu, 28 Jul 2022 10:18:02 -0700 (PDT)
Received: from debian ([2402:3a80:196b:933a:553c:d695:8a60:6d86])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d60cb000000b0021e43650e6asm1535180wrt.86.2022.07.28.10.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 10:18:01 -0700 (PDT)
Date:   Thu, 28 Jul 2022 18:17:49 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: build failure of next-20220728 due to 93ce5e0231d7 ("HID: amd_sfh:
 Implement SFH1.1 functionality")
Message-ID: <YuLEvUKxrcwe2dZp@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Not sure if it has been reported, builds of xtensa, mips, csky and arm allmodsconfig
have failed to build next-20220728 with the error:

drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c: In function 'amd_stop_sensor':
drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c:48:9: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-declaration]


--
Regards
Sudip
