Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F095767FE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 22:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiGOUJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 16:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiGOUJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 16:09:20 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABE919C22
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:09:20 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id mf4so10825940ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=5FVWOTGRmBd67THME281A+u5iAgShcfjsnGpyMupojg=;
        b=XsQvy/WWy6icvWBcyL/XJHCfJ0ZwBi70qT3bkJBFyYJlhJIlVrGYIAlSXRRiNq/tF0
         LYp7CAQaQq2kF1aLGW+HpskqAW1oIuAkknzk57VFx89NQniv63hdLOtJoo+Q4Jgzsxmw
         MGTN3rh0EDW1GqQzjarXm8wf7RuAxYlXmMbb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition;
        bh=5FVWOTGRmBd67THME281A+u5iAgShcfjsnGpyMupojg=;
        b=zk/8IQ6morPHCPdPlLVIkjWB4dhxXk0dWJkkOOi259Lid5i4b54eiBZ5ZJGdGqzj6R
         XYN79HNrv+68Pw8QK7hT/Vw/m7hc+DR32Bkt28O5beK+yA4wZhnailp2mMorcs873T0l
         b/+moUf9Z3932GUntz9e9K/y54vO8TIRV9aou1Tlhx+En/qG3nHH7FzHK2DG5/blrS8q
         lE1v9d118dOGTrDi5F1+vI6HK2kgbgqB7B8OykrsXTxt2gd2SvGf3EsSAcIvv8t98KuF
         aElh8EK2FEC0LD5CBHT/SgtuzME10WPYsS8tnydoESbwTBSFQ7YBZlg1nZiJxAUw0sas
         hU7w==
X-Gm-Message-State: AJIora955AC83wADsLnKp5b2v8KMhN/VtvCy5DW7ONIMSm5J27bRuTeF
        G1bBNOdmymbtDV6Y245YFg16dKq2Jyefeg==
X-Google-Smtp-Source: AGRyM1vLRmUfqHYfwZ4yI8yNE6b56e1USctVg4mLVZQ7+MxexcrClBw48fj0C4QI+1Poj+dHkpgiMQ==
X-Received: by 2002:a17:907:60c7:b0:72b:5651:e1f8 with SMTP id hv7-20020a17090760c700b0072b5651e1f8mr15154093ejc.375.1657915758449;
        Fri, 15 Jul 2022 13:09:18 -0700 (PDT)
Received: from carbon.gago.life (78-83-68-78.spectrumnet.bg. [78.83.68.78])
        by smtp.gmail.com with ESMTPSA id e23-20020a170906315700b0072b810897desm2331678eje.105.2022.07.15.13.09.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 13:09:18 -0700 (PDT)
Date:   Fri, 15 Jul 2022 23:09:17 +0300
From:   Petko Manolov <petko.manolov@konsulko.com>
To:     linux-kernel@vger.kernel.org
Subject: GCC fails to spot uninitialized variable
Message-ID: <YtHJbckxy1FJ3ts7@carbon.gago.life>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Guys,

Today i was bitten by a stupid bug that i introduced myself while writing some
v4l2 code.  Looking at it a bit more carefully i was surprised that GCC didn't
catch this one, as it was something that should definitely emit a warning.

When included into the driver, this particular code:

int blah(int a, int *b)
{
	int ret;

	switch (a) {
	case 0:
		ret = a;
		break;
	case 1:
		ret = *b;
		break;
	case 2:
		*b = a;
		break;
	default:
		ret = 0;
	}

	return ret;
}

somehow managed to defeat GCC checks.  Compiling it as a standalone .c file
with:

	gcc -Wall -O2 -c t.c

gives me nice:

t.c:19:16: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
   19 |         return ret;
      |                ^~~

Any idea what might have gone wrong?


cheers,
Petko
