Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF5259CA32
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbiHVUkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237724AbiHVUka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:40:30 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570D04457C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:40:30 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so12558066pjf.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=3BHC1pk8KI31+SswPTa3tsLnHZ/LE74BAq19PUgh0YI=;
        b=i2/JSIlrWKRYJLDkwbLCysQtjBIYjpL6uCXlxOE1xSNpSvYfNgJWucykEdEqNiE18O
         +Qk8LcIHUgSYmVcDixCm6h/JUEiO4Bs/S46kzUv9JzZZEdMVxCEiYFhDPiD1gbWFP/4c
         TuXg7xrpGXgpmDMU7EuPq7Qtjbw4BkgDLLTEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=3BHC1pk8KI31+SswPTa3tsLnHZ/LE74BAq19PUgh0YI=;
        b=hdCG8oTm0qZuHXrLE9lhfiDXJm1WPCX1Ufyr5s7r8z5LpoGnM5+Hkc7CsJcTxR4Tas
         1ZPkFJPX7vKGm1zYPPyHJ/tVSR5zB6W5BTBuybMCXu44E4dVL8aYAtrUf1c0dPv8XJ2i
         AKRWC+ufOxKaE2zk40GU0meD5b9SPCo1EL8sMWr+/ZJUK8zgldiWoLW4IoU8fDCvoCHW
         l48FFKZW//r2DCmu+Di64yilCLN4trRBEU1s3dhiwoAxXLNmFIp2j629Ms8DakZ4Afbp
         0RempSt4Q6daoRqw39oPm9q+OZVFwMqVMJZDK/QhqPnrIE7Op2D6L/b8fmvsdL0hi8zr
         T+ZA==
X-Gm-Message-State: ACgBeo3Ho80BIuRTsEjcYp2GL0SbQftoUv4RnNPhnP6scUZ3MbcGffB7
        CRgvvuVgGb0nL93YPihQUSxLGg==
X-Google-Smtp-Source: AA6agR7ApGcVUEWx25ayJWgu4aDhbR9X6Ptd7NDoABqsf2d834rneohmIE1FzvPYGtydohUNr29CXQ==
X-Received: by 2002:a17:90b:2c06:b0:1fa:e636:105a with SMTP id rv6-20020a17090b2c0600b001fae636105amr110649pjb.169.1661200829897;
        Mon, 22 Aug 2022 13:40:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902f7c300b0015e8d4eb1f7sm8772425plw.65.2022.08.22.13.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 13:40:29 -0700 (PDT)
Date:   Mon, 22 Aug 2022 13:40:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Stephen =?iso-8859-1?Q?R=F6ttger?= <sroettger@google.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: PKU usage improvements for threads
Message-ID: <202208221331.71C50A6F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I was hoping to start a conversation about PKU usage for threads in two
places, which Stephen Röttger brought to my attention, with the hope of
being able to use these in Chrome:

1) It appears to be a bug that a thread without the correct PK can make
VMAs covered by a separate PK, out from under other threads. (e.g. mmap
a new mapping to wipe out the defined PK for it.) It seems that PK checks
should be made when modifying VMAs.

2) It would be very helpful to have a mechanism for the signal stack to
be PK aware, in the sense that the kernel would switch to a predefined
PK. i.e. having a new interface to sigaltstack() which includes a PK.

Are either of these something the PKU authors have considered? (Or are
there some details we're missing in this area?)

Thanks!

-Kees

-- 
Kees Cook
