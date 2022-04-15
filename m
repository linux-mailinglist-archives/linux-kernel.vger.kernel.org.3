Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00B5502E74
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 19:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344246AbiDORwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 13:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343970AbiDORwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 13:52:51 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB68E8EB4D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 10:50:22 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id w19so15004157lfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 10:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=bCL0/Akj8FjH1PGa3iRKAVbG0AVxF0Pe4iddMznlQ7o=;
        b=H4migTIbNf/CvuglL1kAb+mhPJQmRYV6NeMBI8S8TVgxg6awd65Awdb9GAKRZ38DRL
         BSetPb/T5ABrl9/71NAtmbsdz1N7yT6sb/Ekh83YDe21f6dmsjfHWJsjyIj0uBDyS1zP
         gJHb5h/XMylMDoeObimNC4zaxRpodfSaSlD4jfpBybaw+8rTHQXzIQ5+I/PrA3hSNvpC
         p91/jTgc93jOehFHVbYyGz6MO+CVXfmTm3ZlYhHg/dYXnktcHQkEpSyW27fjQg5GjhrM
         MfWbzJb1rKNYlFcNO+NOJlbcrwp+CfewjfvVR16iTRtooznbIBBC4+QGR4Xp2+WL0Iq9
         j/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=bCL0/Akj8FjH1PGa3iRKAVbG0AVxF0Pe4iddMznlQ7o=;
        b=Fl7gXVxmksPV+GeOQl4hEKJ4dbFIeTwIktOD/BdtJTDGDGaa/tKKcM4KLAPF+IiKDd
         LFODn7AKDqCrCPBtY0lnVc7hP38Ozo+RsGbx4pq4kDCXxSfGDtWksoJlApDdb2xa6jHg
         TyZXW/mKiSH44oiX3Rh20q/66/7Iuf//ozjcdP1XADoX33G9P6GG/jbWA3Vgp6SpCy9J
         8q779574/Wp1tKCsZSgBW1JLXFAKgnXvEsbOpwRieiRmRqnJFjShr+bWmb8RND6aNuv5
         daNArez0+C0raAWRnXf1uX/+YMcph+GzbvGgw+VhdzFfsrFjKHDDGnTegq/P03/i43SK
         FCIw==
X-Gm-Message-State: AOAM530sYgypNOpptdN7fpMQa4w6EMsC5O6+Tc53pIXeypOxiAkDHKgq
        XU9zXtbtEy8KX9FfYtPldMxsE05ho9+Fe1rHNjh8gAHdAOFH+Q==
X-Google-Smtp-Source: ABdhPJzyHAZAQ0lVC0btV4gtakXg5y+xrFCP0Oi0Y5+ivmFKGIyjuqrpdI1WygOPIj1htulNV0NiRkCaBxzieKwDgAo=
X-Received: by 2002:a19:505d:0:b0:46d:167e:b9df with SMTP id
 z29-20020a19505d000000b0046d167eb9dfmr106371lfj.184.1650045020893; Fri, 15
 Apr 2022 10:50:20 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Apr 2022 10:50:09 -0700
Message-ID: <CAKwvOdmFzNZ_r1itJJkAh-VPMCjqvCCB1DPXSUwUFeeAjoJviA@mail.gmail.com>
Subject: plumbers session on BPF/BTF support in the GNU Toolchain
To:     david.faust@oracle.com, "Jose E. Marchesi" <jemarch@gnu.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,
Jose and I are currently in the planning process to put together a
Kernel+Toolchain microconference track at Linux Plumbers Conference
this year (Sept 12-14) in Dublin, Ireland.

Would you and Jose be interested and able to give a presentation on
BPF and BTF in GNU tools?  There will be an audience of kernel
developers there, so discussions with kernel BPF folks could be
facilitated in person.
-- 
Thanks,
~Nick Desaulniers
