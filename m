Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FDA4E5BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 00:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345488AbiCWXbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 19:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345476AbiCWXbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 19:31:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC1869CCA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:30:21 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id qa43so5850513ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HfS7RNhMsAvhm3dkViHCIr0vMqh85tM7E/+ao0kRKJs=;
        b=tW2EeH/eBKHhPEoNUW7aeZDdjSo2N3sR5g8/rjFyrWWIfWC9lzpK7okoF/VHQoK3/R
         nRnXQzDF/+QOzMU5yhwb972fhRH79C3FASiflIzZF8aFHuGLrEbg9V2ojYFvJoHWrXTg
         Rm9xIyV8e3TrJCUCw+B+7bIVxPbQfaXlyC9ysfKC0uwry4x2DrEiYC++/51pb+RW2DU9
         WKnqE3tlVdqzQHCILZG7Fp5+Hy0OD3VN+P4mdQ35EngOytiOZ/9St5He9SjbDhSUlCYV
         rK+T4hZ4nfTY9AnZMav6bqNLsIOBTA+GiUrJF5I4n8B4BsfziS9oabg3fqvrik1d1MWi
         zURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HfS7RNhMsAvhm3dkViHCIr0vMqh85tM7E/+ao0kRKJs=;
        b=6GGJlnx8H5FXOltLyI9UqZpo0ZJ/971PgoQtcxC38DxKCTKtb7Z2DvdiXunNPE+AoR
         DWDbTEfjyTnEnOsTG2QojCqGM6kmRS20G5HVjZX2+s7TLKksQmw7uJ88uxZxd2MW5Fmf
         OXEvSqhmUDH3OXJJ+EIstLAWpHKMQ1d8Mwg5QwXToFaIL3LIPrIpsBgRufU2w1C5xOO8
         ETs5fyxkZ9mmXhIvljfM23KaxeI6nVzLbFxyADnexsKEqGzS0ADwsTMr4bqQPHoeNEp6
         44CpAX2+WGer0VXMoQAGugr2nvFd793cdVsT4dT5s2Qs7mI9IO25XSMxMapWWbQXIAYk
         siog==
X-Gm-Message-State: AOAM533gok2ex/20jmbDCifsUqOicYW5O+i4HEPsRJvWosFPdFR4+BQ7
        xeQsnRN6+xA5IZuXZReAADjsMJ/1X0/tXBTI4orhBw==
X-Google-Smtp-Source: ABdhPJy9tB8cZmFLq7/08WeSSCigTCYfwMBIqUubd0WCU7po5l9Q1JOyl8dsivDi3xN38be3+/LEihyciTgUmeVucoU=
X-Received: by 2002:a17:906:d54d:b0:6e0:1f9b:5064 with SMTP id
 cr13-20020a170906d54d00b006e01f9b5064mr2733192ejc.59.1648078219829; Wed, 23
 Mar 2022 16:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220224055350.1854078-1-keescook@chromium.org>
In-Reply-To: <20220224055350.1854078-1-keescook@chromium.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 23 Mar 2022 19:30:08 -0400
Message-ID: <CAFd5g47HMRbKOFbANe_kZ8Td4OHxxwDqpszV515uaMzsz9DoXw@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Do not colorize output when redirected
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

On Thu, Feb 24, 2022 at 12:53 AM Kees Cook <keescook@chromium.org> wrote:
>
> Filling log files with color codes makes diffs and other comparisons
> difficult. Only emit vt100 codes when the stdout is a TTY.
>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
