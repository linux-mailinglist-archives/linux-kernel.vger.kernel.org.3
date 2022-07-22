Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0383E57DF54
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbiGVJry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbiGVJra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:47:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF44222A0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:44:13 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m17so5463501wrw.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MoNc2+b5ERFS4RuKMoRTmb2TkOjM7yyfkHgxoWj5q+o=;
        b=FVeNbmKWVTad88jc0tmNj1GY0l8dDL19vd8IGy8FY1hccAMoQxqxa+o/mveAdlKOpC
         eIZirrq4x3gWSytGhzh3Pj/KzsptFgt52J9G9MBpwcFglStudxCh7Flr8gepZZI99Ekg
         4uR+Dw1/9Vkw1TzPCuAu0rn1Ce5jqB161hTvdEL0Hf+JrCwVoNgBVxHnfRGwMlwsnppG
         FIkJCvESwe8JbFuH+gkblppbjAf4VLDagmZ3CMf54M6oIa0TZjWGJr5HwAbgygaI0ulp
         PD6AU7x/bFtHgE+AQFFvFK9BtC7BhzPNk+JnjIf7xNVXa9VUoYnHVO2ulZw0O5an46J3
         gWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MoNc2+b5ERFS4RuKMoRTmb2TkOjM7yyfkHgxoWj5q+o=;
        b=c/1ynSVy5uqKeh644ZMA9NduOTGJUn4ZYT8xeCTTNnYx42C7KaPmKL6fpbrUY2ASFE
         M/nT36M5Oh61ryMuRRVp9wNRzmEiPEPHG7fs/qE5DfWHKVQ+mVD/f0r5Qz/qLHnonLzF
         pnbha0q0shWEzbBPWvtssLCbpb8Wc6EGwqX56Aw0jVbb5cAOlGgGsTPexDQ30wqp9E28
         iV3DJ7T41I+UcFBsOW7ufQVCGk7WabhzX0caoXnwjhLi2W32nQ0+lam2zzu2Wf2UCYtq
         GyZvE8zI+inAInWORXIzdUgCvBWgGMVtCAXR/eHKTJHNxYLjDZRga7J5wEh6zVEXCf2J
         ETZg==
X-Gm-Message-State: AJIora+2vA1mdn/GIayWublOdRRO057iJfcucqi2u8ZWKVpnraAO+iu5
        flVRm3bEtMmAjKP7x9nhN2USOQ==
X-Google-Smtp-Source: AGRyM1tldlL57wP0OI74eE9Sp/rhc0RK1dGFaw2Aj9LKVchWXXfLDmLTqs6tKhAS+0FY+G5e6JEt2Q==
X-Received: by 2002:a5d:4b87:0:b0:21d:7019:80c6 with SMTP id b7-20020a5d4b87000000b0021d701980c6mr1844459wrt.234.1658483052060;
        Fri, 22 Jul 2022 02:44:12 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id q15-20020a5d658f000000b0021e48faed68sm3949791wru.97.2022.07.22.02.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 02:44:11 -0700 (PDT)
Date:   Fri, 22 Jul 2022 11:44:10 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Vikas Gupta <vikas.gupta@broadcom.com>
Cc:     jiri@nvidia.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        dsahern@kernel.org, stephen@networkplumber.org,
        edumazet@google.com, pabeni@redhat.com, ast@kernel.org,
        leon@kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net,
        michael.chan@broadcom.com, andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v5 1/2] devlink: introduce framework for
 selftests
Message-ID: <Ytpxau8q+L5vEyIh@nanopsycho>
References: <20220722091129.2271-1-vikas.gupta@broadcom.com>
 <20220722091129.2271-2-vikas.gupta@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722091129.2271-2-vikas.gupta@broadcom.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Jul 22, 2022 at 11:11:28AM CEST, vikas.gupta@broadcom.com wrote:
>Add a framework for running selftests.
>Framework exposes devlink commands and test suite(s) to the user
>to execute and query the supported tests by the driver.
>
>Below are new entries in devlink_nl_ops
>devlink_nl_cmd_selftests_show_doit/dumpit: To query the supported
>selftests by the drivers.
>devlink_nl_cmd_selftests_run: To execute selftests. Users can
>provide a test mask for executing group tests or standalone tests.
>
>Documentation/networking/devlink/ path is already part of MAINTAINERS &
>the new files come under this path. Hence no update needed to the
>MAINTAINERS
>
>Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
>Reviewed-by: Michael Chan <michael.chan@broadcom.com>
>Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Just a small note below. Take it or leave it, I don't mind that much.

Thanks!

>---
> .../networking/devlink/devlink-selftests.rst  |  38 +++
> include/net/devlink.h                         |  21 ++
> include/uapi/linux/devlink.h                  |  32 +++
> net/core/devlink.c                            | 223 ++++++++++++++++++
> 4 files changed, 314 insertions(+)
> create mode 100644 Documentation/networking/devlink/devlink-selftests.rst
>
>diff --git a/Documentation/networking/devlink/devlink-selftests.rst b/Documentation/networking/devlink/devlink-selftests.rst
>new file mode 100644
>index 000000000000..0e9727895987
>--- /dev/null
>+++ b/Documentation/networking/devlink/devlink-selftests.rst
>@@ -0,0 +1,38 @@
>+.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>+
>+=================
>+Devlink Selftests
>+=================
>+
>+The ``devlink-selftests`` API allows executing selftests on the device.
>+
>+Tests Mask
>+==========
>+The ``devlink-selftests`` command should be run with a mask indicating
>+the tests to be executed.
>+
>+Tests Description
>+=================
>+The following is a list of tests that drivers may execute.
>+
>+.. list-table:: List of tests
>+   :widths: 5 90
>+
>+   * - Name
>+     - Description
>+   * - ``DEVLINK_SELFTEST_FLASH``
>+     - Devices may have the firmware on non-volatile memory on the board, e.g.
>+       flash. This particular test helps to run a flash selftest on the device.
>+       Implementation of the test is left to the driver/firmware.
>+
>+example usage
>+-------------
>+
>+.. code:: shell
>+
>+    # Query selftests supported on the devlink device
>+    $ devlink dev selftests show DEV
>+    # Query selftests supported on all devlink devices
>+    $ devlink dev selftests show
>+    # Executes selftests on the device
>+    $ devlink dev selftests run DEV test flash

s/test/test_id/

[...]
