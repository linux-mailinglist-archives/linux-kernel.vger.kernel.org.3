Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC57589346
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 22:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238290AbiHCUcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 16:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238098AbiHCUca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 16:32:30 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1815B7AE
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 13:32:27 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x21so10144745edd.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 13:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=f0bwgO5Y6DZvlx+aNQfiCPBi+5cjtr/D/YquyyJnj2Y=;
        b=YlLbkAWLnaGvgbUZknMUXGio9T544H9Q8guK7U9X3g5XNnPDRkYIs8s62FnCLUOTFL
         tXtP5R1mN4sIJqQiBO6t1CDgfdrsvNoSiVd9NbyQ3tRMGy4tvCoaHwCDHn0LFQlVwFIl
         y02noIyhQE/HQo3DM0vEUSn4eAdmq+fISCuvNApGaODeclvuCo9ynWDnK9cicFOtPKc1
         h8UN9z2fsIBphM1RGy/06PXlMIJncsKRMoPGwl229Q1+yOkKT2nm1tMvswHWFTOtbRB6
         fqgTfJC4t3G+TXzQm/sDNF5HFnsZJzyUr2SOFbdHW6X5EQqscyriJ+r+vSIAmRKnSe0O
         ghrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=f0bwgO5Y6DZvlx+aNQfiCPBi+5cjtr/D/YquyyJnj2Y=;
        b=vj6vaM5mvfk00vqmK2J/AOjP+BiEYkjsUC0bY1nH7m+Kb3iHdR+y6YlQ+W472KQaYy
         FSdDODWBIXmWC5evM/eDciRHx/PiaUYCOxNxZfNRLUwYCrw5VaKtQRISpMzWoj2t/b1M
         CyhRgnQThnwAj/yZtJVAR6A0HD3RBnh6a53nDX3of7JKmN4agowaRk+ivM/bok5hc0kd
         xgrCXn2zTnvKddPR3MPOJgcJpKm8/ROWFHaZz2AX/zlDlVgKVWV1Ed/E8l5vG7TEyjfA
         P0vOA+P14O4hQXsqKx7G8u3BN9hyCp+gfTrrsa4yglm/zSeWHVnQ6yokt8oatzfdsTt3
         UTVw==
X-Gm-Message-State: ACgBeo0f81alEFFSHdL7FH4kCmqQptXxPNYSVjQHqK9MqImsiCISihGT
        jpsQVv0j5J+AunabeHeOpfzIZqEJsvztnguzP65vNg==
X-Google-Smtp-Source: AA6agR6HWU92GtJAYExC2AMgER8UwS9Iax4Ao3eTMs6yxLQvwgm+Tsb/m5yFI+dWOCBmPKO2p6CvihXc/q25NTwQfVo=
X-Received: by 2002:a05:6402:4302:b0:43e:18c7:e003 with SMTP id
 m2-20020a056402430200b0043e18c7e003mr7574346edc.198.1659558746011; Wed, 03
 Aug 2022 13:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220713005221.1926290-1-davidgow@google.com>
In-Reply-To: <20220713005221.1926290-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 3 Aug 2022 16:32:14 -0400
Message-ID: <CAFd5g46zd2wU6L1LUmxeS=adpukPyoD65yfopMeQCMpt9iYL0Q@mail.gmail.com>
Subject: Re: [PATCH] module: kunit: Load .kunit_test_suites section when CONFIG_KUNIT=m
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        linux-modules@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 8:52 PM David Gow <davidgow@google.com> wrote:
>
> The new KUnit module handling has KUnit test suites listed in a
> .kunit_test_suites section of each module. This should be loaded when
> the module is, but at the moment this only happens if KUnit is built-in.
>
> Also load this when KUnit is enabled as a module: it'll not be usable
> unless KUnit is loaded, but such modules are likely to depend on KUnit
> anyway, so it's unlikely to ever be loaded needlessly.
>
> Fixes: 3d6e44623841 ("kunit: unify module and builtin suite definitions")
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
