Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4412F4BE6D7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376728AbiBUNxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:53:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376929AbiBUNwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:52:40 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62A59FE2;
        Mon, 21 Feb 2022 05:52:15 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id p15so33383231ejc.7;
        Mon, 21 Feb 2022 05:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0jY72INQ+Kfy8mY8YvrubiEx7D1Fcsl6Uov11Zh6YiI=;
        b=g94bR3IUa/Sz6N2lLkK+W14JjY/Btaxaboed/zL+wYivm8kvaxmhWznwk8/UYc6898
         JHW33UhKXpjVA1aWQuQa0+GE0saEure8olWa1Im97HL6BV1iFix+lMLzeg8/I8mXYHl5
         GI7B9+BafVrzV7397Fzjo3jppxC/I/zLdnYzQmzaapAGbzgwH+ShEEqaON4PBxt1Be6Y
         OxC7bw7Rg+Y0q8FN4CCqtcX8BonFjdxDBxmUZfqWbfp6lozZn7jB/xc/KjOgyoshu7xu
         8XNrnQbnrQii3KG4ilqoJOmKn9MCHkIqGojiD4SGfsRUoOYUaHxivhM/0FqpPW8e4Jl3
         NDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0jY72INQ+Kfy8mY8YvrubiEx7D1Fcsl6Uov11Zh6YiI=;
        b=e8IaX/n/oBQ2eBakBH6mBZx6jInDN849TKK8Ql1uYc/rQ1qxoh8Rv614Etum6lk5D6
         vjwlUcQyAMLGSi/lwOfZhUme/YcGKTt9AJNcF6f2OLAXLI8696DpkslskQ0suO7zCnk7
         WmffaBOIDdvbxpKgKZCtlRlKF8t61PQRzbZECylivJQBCxpFBbtNg214YjAnEJoZulUy
         4t8nPcyYJJwHytUeYPlVqk86QFZ9bewQBOVvZB/wZEKTh6fTQZKqEMLAZxUjAZwNMT0r
         XxwBJTlwZvKf/aB+OfpaUUOWta95QKh7NzS0X9M9HFOZ+IVxd8c7zcsQz5msqdYyKc5d
         U1tw==
X-Gm-Message-State: AOAM533EANB+H0KOActQW1UiMrpCh/ZF6GL7DuAWT6wS58NuE8wqVxUQ
        qIXEWz/xdaTwxdMwc4DVk2pPIPY6rMtDhA==
X-Google-Smtp-Source: ABdhPJxdWvEQ1IuXHxmlfTB7XK4BITCX2Ck5UcH3i+QD3QSD/7jvpwzt82YhNtCQS/328ucrWRANpw==
X-Received: by 2002:a17:907:2711:b0:6cf:350:81c3 with SMTP id w17-20020a170907271100b006cf035081c3mr15679810ejk.712.1645451534338;
        Mon, 21 Feb 2022 05:52:14 -0800 (PST)
Received: from ubuntu ([155.133.219.250])
        by smtp.gmail.com with ESMTPSA id 23sm5107799ejg.209.2022.02.21.05.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 05:52:14 -0800 (PST)
Date:   Mon, 21 Feb 2022 14:52:13 +0100
From:   Daniel Kestrel <kestrelseventyfour@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Kestrel <kestrelseventyfour@gmail.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add support for WASP SoC on AVM router boards
Message-ID: <20220221135213.GA7264@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a popular set of Lantiq xrx200 router boards by AVM in
Germany (AVM Fritzbox 3390, 3490, 5490, 5491 and 7490) which
have the strange implementation of having the wifi cards
connected to a separate memory only ATH79 based SoC. It has no
persistent storage and no access to any resource on the Lantiq
host, but is connect to the Lantiq GSWIP switch on an additional
fixed internal network port.
This kernel module is to support booting the secondary SoC called
Wireless Assistant Support Processor (WASP).
After turning it on, a small network boot firmware is sent to
the SoC by using mdio and when it is started, an initramfs
linux image is sent to the SoC using raw ethernet frames.

The whole procedure takes about 6 seconds, if there is no error.
So far tested on 3490, 5490 and 7490 devices based on OpenWrt.

Patch 1/3 adds the vendor name
Patch 2/3 adds the dt-bindings
Patch 3/3 adds the remoteproc driver

To build and run, there is OpenWrt PR 5075.

I have read a couple of responses on other submitted patches and
after that I did the following changes to my code:
- Check for c style comments
- Remove all dev_info output
- Did run checkpatch.pl before, but double check and run again
- Add timeout for send and receive socket in order to not stall
  the kernel module in case of blocking tcpip calls
- Add a timeout to while loop in avm_wasp_load_initramfs_image
  to make sure the loop is not infinite
- Add put_device after using (of_)mdio_find_bus
- Use devm_gpio_free instead of gpio_free
- Check for all of_... calls if they increase ref count and
  add of_put_node if required
- Replace all return -1 with return -<some errno>
- Check if the os methods return error and/or NULL and look up
  how other callers in the kernel sources check for errors
  after calling those methods
- Try to find any pointer references that were not checked in
  code running before accessing them
- Rename all methods to start with avm_wasp_
- Restructure code to aquire mdio bus just before using it and
  free it right after avm_wasp_netboot_load_firmware
- Replace rproc_add and rproc_alloc with devm_ methods and
  remove rproc_del and rproc_free
- make dt_binding_check and fix missing gpio include

I likely still have missed things.

Daniel Kestrel (3):
  dt-bindings: vendor-prefixes: Add AVM
  dt-bindings: remoteproc: Add AVM WASP
  remoteproc: Add AVM WASP driver

 .../bindings/remoteproc/avm,wasp-rproc.yaml   |   93 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 drivers/remoteproc/Kconfig                    |   10 +
 drivers/remoteproc/Makefile                   |    1 +
 drivers/remoteproc/avm_wasp.c                 | 1251 +++++++++++++++++
 drivers/remoteproc/avm_wasp.h                 |   95 ++
 6 files changed, 1452 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
 create mode 100644 drivers/remoteproc/avm_wasp.c
 create mode 100644 drivers/remoteproc/avm_wasp.h

-- 
2.17.1

