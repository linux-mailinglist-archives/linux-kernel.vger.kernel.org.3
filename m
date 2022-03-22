Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53CA4E3A82
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiCVIZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiCVIZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:25:33 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A4165E6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:24:05 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h23so23188015wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=87Bh+QidxYMpsTYJqSrvJQ/cLDGkqP1N5aKJGexsbZ8=;
        b=UntMI064I4h4ouP4KOJ7gqzkm7PmMH9vI17MKSNFgn3wq/uh0ECMIt0Wum/7pYQLIG
         CF5qBREq7d7xNCgDHi+Ssg57wHI7f9XS9l2hCZ3FPmB/Y8Z7aC4BhUPhqVjCnfoZhOLm
         CaKh/rBCwdFKiC7OokdIBLk11nGnzs+X/16vfiRfDNq7ikugOnBBSpW1pMOOlxZXFs8Z
         w1yNrULd3jjat3CWVriijurqzl6TaditTbuVlTI3zuNc80i3PcLCZw1oCUfa32DelVTa
         aFzFvd4SR41BRDH2prRLnHcPr/BoVrSe2MhkpDnMRxeEPk6Oyi5jgGA6Mz7oe+1Sbr8Y
         xbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=87Bh+QidxYMpsTYJqSrvJQ/cLDGkqP1N5aKJGexsbZ8=;
        b=M4hlVYBtrLAMXK/w3JPNdp7gmuZeKxv9yasaCQ6wUX9nYK5x34Hd5V/lBUfnVNEPXt
         EFELHKUTq9tS7k9HuRVBSZJyLOcHDfbcvrehs96P+gR7UqF+r0DNtOznhTFLSXmGXXqs
         pX0ntAO03ofYtNyoKDBqdnXrP5SG3E50rbvpQdBmFnbENQ4Ljotsvkj8PixMRg1Fl6rm
         JrmvxuKdhdTAnjn9CfaqUenlzjfnVmc5OXm3UagzHD0Ud0SRcsLL+zMYn4ZrmHpkj1nr
         w9x4XE/3IUo2zg3AWzLkGtnGQ6Blan8IDNBfAopJq39uNxIWLpxnk7Lt1dT3BMrx7k2k
         UDTw==
X-Gm-Message-State: AOAM532GL32mXCH118JK10SMQH+epDp301EKbHETA/AhQcLrTgU0l0Dj
        uWZeKX9vfBAcSfiReipE1dtsow==
X-Google-Smtp-Source: ABdhPJzjZUCCluCimIHyo0ySg/7PluFhbVLtmTWABCnNMk1Pt/Gy63nrTht/rrm7cCmzgiESIIYd2w==
X-Received: by 2002:a5d:6542:0:b0:203:da90:969f with SMTP id z2-20020a5d6542000000b00203da90969fmr20612878wrv.479.1647937443900;
        Tue, 22 Mar 2022 01:24:03 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id b3-20020adfd1c3000000b00203f94379a4sm10515962wrd.67.2022.03.22.01.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 01:24:02 -0700 (PDT)
Date:   Tue, 22 Mar 2022 09:23:59 +0100
From:   "Steinar H. Gunderson" <sesse@google.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf intel-pt: Synthesize cycle events
Message-ID: <YjmHn7ewyUEQBzDj@google.com>
References: <20220321181447.1323742-1-sesse@google.com>
 <e9126f11-177c-cc2f-7620-fdd7b3f363c0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9126f11-177c-cc2f-7620-fdd7b3f363c0@intel.com>
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

On Tue, Mar 22, 2022 at 09:13:42AM +0200, Adrian Hunter wrote:
> Thanks for sending the patch.  There is one variable leftover from my
> earlier suggestions - see below.

That should be easy enough to fix. :-) By the way, I updated the
documentation slightly in v2 to reflect what you said about when CYC
packets are emitted, and the possible (partial) mitigation of noretcomp.

/* Steinar */
