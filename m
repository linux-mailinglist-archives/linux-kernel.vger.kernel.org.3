Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09510517B8D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 03:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiECBOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 21:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiECBOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 21:14:09 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71223E0A4;
        Mon,  2 May 2022 18:10:33 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-e93bbb54f9so15897641fac.12;
        Mon, 02 May 2022 18:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=afJH5iqVo2x/jW5TxtB/M5xtYzbdyfHarrJP9AysXw8=;
        b=1Ny4089S5DjjUNE1ZVTRGUL/E5tKMHwYyyV0/r9p5t1pVe3EflCXu9htOQQJ/rt4ns
         ZOKO9/z0+GPPPQYAiiMCK5sqnjLR2FnvyQ3QZVxAAbNXq5XexPVujeuzfHK9BTBfDqS4
         7cehOAVkWQFShEOfZnCM7ym2gxgdeTw2jfkCLHjLZDP89eLOGoHPBlTEi+OXvOwso/tb
         80eZNx15Iq66X0+1LNkm1tKpTg8/SldYekpf51Qfbz/XBQvqZsrDDApJREzNZHgh+E5a
         3BDfXS7dZsISRrt0laYXspw/01/98GzaPAj49QFux+2bN7beMYo27XdZGeaRdvDFkDT4
         V6Fw==
X-Gm-Message-State: AOAM530P5TSVtyOxyqUQk17lMfBca3xQ5evxV/QmSnSiOj2TzMRruYOk
        cczAj7qLXB3V/6LdP4FxdIcNmVTcaQ==
X-Google-Smtp-Source: ABdhPJzR818A8CrYdsHAQej2SNyjak3oYeBZa1Ms4RsgS3KU8wDyZcQ7abCf4os2SaukIA4qGBANFg==
X-Received: by 2002:a05:6870:d587:b0:e1:e7f1:5d48 with SMTP id u7-20020a056870d58700b000e1e7f15d48mr826708oao.275.1651539492367;
        Mon, 02 May 2022 17:58:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q21-20020a4ad555000000b0035eb4e5a6d5sm4410995oos.43.2022.05.02.17.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 17:58:11 -0700 (PDT)
Received: (nullmailer pid 2157914 invoked by uid 1000);
        Tue, 03 May 2022 00:58:11 -0000
Date:   Mon, 2 May 2022 19:58:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     pantelis.antoniou@konsulko.com,
        Slawomir Stepien <slawomir.stepien@nokia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slawomir Stepien <sst@poczta.fm>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2 2/3] of: overlay: unittest: add tests for overlay
 notifiers
Message-ID: <YnB+I9q7pjdx2Rtq@robh.at.kernel.org>
References: <20220502181742.1402826-1-frowand.list@gmail.com>
 <20220502181742.1402826-3-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502181742.1402826-3-frowand.list@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 01:17:41PM -0500, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Add tests for overlay apply and remove notifiers.  Trigger errors
> for each of the notifier actions.
> 
> These tests will reveal a memory leak problem when a notifier returns
> an error for action OF_OVERLAY_POST_APPLY.  The pr_err() message is:
> 
>    OF: ERROR: memory leak, expected refcount 1 instead of 3,
>    of_node_get()/of_node_put() unbalanced - destroy cset entry: attach
>    overlay node /testcase-data/overlay-node/test-bus/test-unittest17
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> Changes since version 1:
>   - patch 1/1 v1 did not apply on Rob's dt/next branch, rebase on top of
>     5f756a2eaa44 of: overlay: do not break notify on NOTIFY_{OK|STOP}
> 
> Output of the new overlay notifier unittests, as filtered by
> scripts/dtc/of_unittest_expect:
> 
>    ### dt-test ### pass of_unittest_overlay_notify():2825
> ok OF: overlay: overlay changeset pre-apply notifier error -16, target: /testcase-data/overlay-node/test-bus
>    ### dt-test ### pass of_unittest_overlay_notify():2846
>    ### dt-test ### pass of_unittest_overlay_notify():2851
> ok OF: overlay: overlay changeset post-apply notifier error -17, target: /testcase-data/overlay-node/test-bus
>    OF: ERROR: memory leak, expected refcount 1 instead of 3, of_node_get()/of_node_put() unbalanced - destroy cset entry: attach overlay node /testcase-data/overlay-node/test-bus/test-unittest17
>    ### dt-test ### pass of_unittest_overlay_notify():2857
>    ### dt-test ### pass of_unittest_overlay_notify():2862
>    ### dt-test ### pass of_unittest_overlay_notify():2866
>    ### dt-test ### pass of_unittest_overlay_notify():2869
> ok OF: overlay: overlay changeset pre-remove notifier error -18, target: /testcase-data/overlay-node/test-bus
>    ### dt-test ### pass of_unittest_overlay_notify():2880
>    ### dt-test ### pass of_unittest_overlay_notify():2888
>    ### dt-test ### pass of_unittest_overlay_notify():2892
>    ### dt-test ### pass of_unittest_overlay_notify():2895
> ok OF: overlay: overlay changeset post-remove notifier error -19, target: /testcase-data/overlay-node/test-bus
>    ### dt-test ### pass of_unittest_overlay_notify():2902
>    ### dt-test ### pass of_unittest_overlay_notify():2909
>    ### dt-test ### pass of_unittest_overlay_notify():2914
>    ### dt-test ### pass of_unittest_overlay_notify():2926
> 
> Note that four new kernel error messages are triggered by the new
> tests, and of_unittest_expect labels them as expected errors with
> the string 'ok ' in the first three columns.
> 
> A fifth new kernel error message is a real bug, which will be fixed
> in patch 3/3:
> 
>    OF: ERROR: memory leak, expected refcount 1 instead of 3, of_node_get()/of_node_put() unbalanced - destroy cset entry: attach overlay node /testcase-data/overlay-node/test-bus/test-unittest17
> 
> 
>  drivers/of/unittest-data/Makefile       |  10 ++
>  drivers/of/unittest-data/overlay_16.dts |  15 ++
>  drivers/of/unittest-data/overlay_17.dts |  15 ++
>  drivers/of/unittest-data/overlay_18.dts |  15 ++
>  drivers/of/unittest-data/overlay_19.dts |  15 ++
>  drivers/of/unittest-data/overlay_20.dts |  15 ++
>  drivers/of/unittest.c                   | 198 ++++++++++++++++++++++++
>  7 files changed, 283 insertions(+)
>  create mode 100644 drivers/of/unittest-data/overlay_16.dts
>  create mode 100644 drivers/of/unittest-data/overlay_17.dts
>  create mode 100644 drivers/of/unittest-data/overlay_18.dts
>  create mode 100644 drivers/of/unittest-data/overlay_19.dts
>  create mode 100644 drivers/of/unittest-data/overlay_20.dts

Applied, thanks!
