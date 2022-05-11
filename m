Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF95252407D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348978AbiEKXAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbiEKXA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:00:28 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDD58A7CA
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:00:26 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id e3so3616617ios.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=MI1e77NG2MLHV0OL9aS/H9bc3NGijrDFsz/FahQ7nNg=;
        b=IUC0DpXbEo3chYIKlYqeDAlUPjO7udTU9gR9oVwhGdHmO+uoIp9dMVW5WiOGwngZDt
         vxBdslP469ph+Ra+rKcFIFnw/LwFad2JT59/afNxvEOieJihVoKxgjxljXNwcgLMrgw4
         puRSISqD3dYEnNKdaAm1w3tM1N0Nnj5ZAGn5KEjn8D+2FaleZG/A/VtetdP5mOSAf75Q
         STCsP7ZchBEgZlM8eKQ83Ujhew8xLkNWDsjCUrn2FgB+vz+sNGTptkZmUcO2XR+IAB2/
         0bKOG67YVweWHm+Z18o7B3JX5Q8sJAmCI1cGExuFy7phuHpvyZYU9Z9Jryvk2yjCCD0t
         /Cag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MI1e77NG2MLHV0OL9aS/H9bc3NGijrDFsz/FahQ7nNg=;
        b=zgtpZlKGNo1Gnnix8xVE1qs/eDsfD0GcVDp7xvbCfBGvkp7oW3k7ts4I37d78iNnlZ
         Op6GdDJR1HCyp3ZhnjfZlTN0fuUEfp/DqO178q92qLCyzTsKYG8HpLkZ4xCfYJxcZ411
         J/Yt8zoqjFZlaU++mUw0tlOGkQJSL+NKCPjF2ynZFvY5KHe5Ams37dPKrkaRvHSxXaB3
         B0ueAneMuF7TcLXMtwqNF94O4bZDhPUyOPNDJClXrwHNWkwerINrK4q6bE9Jgrl9W1H0
         9YRk1iuM91XR75+H9fa38hq9fuu7YabQG0J7yFWqjy9Sh163gEH2I9hyoDDCsQNEIZwz
         3UHg==
X-Gm-Message-State: AOAM533gVL6j0LBYP/KtmZntlRn4l5rXSEiU+lpMlsu/KOP5HoEzruKX
        GcP976mRnzOSAKXum8VtymtJe3mBVF7nS5sUQE4DBqbSRq4aqA==
X-Google-Smtp-Source: ABdhPJzeQPZ0ndPHibWDA9Pa+B1O9ILo8wSLnwAD/agF/fMvZIW1nFjFmVTEWe4X68j1/BHEAMuNblh8qjP6hPo1TsU=
X-Received: by 2002:a05:6638:1487:b0:32b:e970:2acf with SMTP id
 j7-20020a056638148700b0032be9702acfmr10255965jak.109.1652310025623; Wed, 11
 May 2022 16:00:25 -0700 (PDT)
MIME-Version: 1.0
From:   noman pouigt <variksla@gmail.com>
Date:   Wed, 11 May 2022 16:00:14 -0700
Message-ID: <CAES_P+-khQGqec2_xqVEU4m0b9WscvLUinQmPXi6zX_P4mP+hw@mail.gmail.com>
Subject: Mapping ram memory using ioremap
To:     linux-kernel@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are using part of DRAM as shared memory
between DSP and SoC. However, DSP
can only access higher 1GB of DRAM.

In order to map the aforementioned memory
I tried using ioremap and it blurted out the
warning as mentioned in this article.
https://lwn.net/Articles/409700/

What is the alternative to using ioremap to
map specific RAM memory region for use
in the driver as shared memory?

I tried memremap + reserved memory as well
and it failed.
