Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37F959649B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237606AbiHPVZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237602AbiHPVZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:25:22 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2FC8C039
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:25:21 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso85360pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc;
        bh=bFTgb0MyDNHElcHcfE66JD0U1t++ZcmngfUIUipRBa0=;
        b=MFZlty/T5ZlDBkujF13rtleo+pUP0+OugWJ730FEEFarjRnF5xN/XOBXKCOHb75VdU
         x/rr0MxCfay2pB1TGwQjiXGEdkeKO2OLgqG1TqHv7doagOgD6XmNBH0gxtC4gVzZvghO
         jYGJaDbm0HlgBVZNcZwtzHkFZF9V2+AQrWanZGdbnufTqqArATPdK/MH9VXqz5TdcSLH
         I4gNY/ch8oxNDY7vI4/0wyNgZlXLjWcGPCC0hi4b58Zd3OysmyUrGCOQlUEUcbArg4+e
         aVnKbrDGyshUl9Ma3MxAV8yO0KbWw0tgk/TLPCD89HuCk+dNrJRLHpikO10JxROTUyvP
         FHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc;
        bh=bFTgb0MyDNHElcHcfE66JD0U1t++ZcmngfUIUipRBa0=;
        b=01TT9OUPQF8nvBhnll+R3bo42ypGzB4yDXTvzx0wjrudu7JK4A/WUb2v+SMM+D+lIy
         XKAYnPs9t6COXVw3MXeGQGYHyeJjHTACk2435hB39K206Mn9cQdaUKew6jchIL+dAMEg
         DDIx1seotmt3Xo6EMEmLIqCuvBcdqnNFu+ISJIoYiVfBh8/4stEvNVSdwJ0ij5EICW8w
         3GSjFBrLclvAJu45zDHh4nxQPr9ElG+cqwh5HJSYHdqCP+a2EhwkJpQ/uvFTxpFJP8hZ
         iQSNpmDdfX7S4tHfWz87cJuiQMF+Iaeo/u3+XSJDKmusHPYj4gA12OPQH6BxqjyGyqz/
         xnuQ==
X-Gm-Message-State: ACgBeo0r46w+d8O8UkIQt311ujmzhK+m2Ra+FS1Vcn9j2TL3HnaSeN74
        6CBXMjxKGbnKGXn68JwnJ0f7XA==
X-Google-Smtp-Source: AA6agR7e3Tte3sx6cv3dVpIoZdC2K6gncQgCVMsjYEmv+jkwyGumqBTSaYyZHjEUVcrKp1sFlH1aGg==
X-Received: by 2002:a17:90b:33ce:b0:1fa:81bb:aeba with SMTP id lk14-20020a17090b33ce00b001fa81bbaebamr464120pjb.205.1660685120939;
        Tue, 16 Aug 2022 14:25:20 -0700 (PDT)
Received: from [2620:15c:29:203:9a1b:5709:54ba:ae28] ([2620:15c:29:203:9a1b:5709:54ba:ae28])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b0016d785ef6d2sm9469653plh.223.2022.08.16.14.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:25:20 -0700 (PDT)
Date:   Tue, 16 Aug 2022 14:25:19 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Jacky Li <jackyli@google.com>
cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Marc Orr <marcorr@google.com>, Alper Gun <alpergun@google.com>,
        Peter Gonda <pgonda@google.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 2/2] crypto: ccp - Fail the PSP initialization when
 writing psp data file failed
In-Reply-To: <20220816193209.4057566-3-jackyli@google.com>
Message-ID: <18f39270-87d3-3d3d-c60b-77465f81f3a0@google.com>
References: <20220816193209.4057566-1-jackyli@google.com> <20220816193209.4057566-3-jackyli@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2022, Jacky Li wrote:

> Currently the OS continues the PSP initialization when there is a write
> failure to the init_ex_file. Therefore, the userspace would be told that
> SEV is properly INIT'd even though the psp data file is not updated.
> This is problematic because later when asked for the SEV data, the OS
> won't be able to provide it.
> 
> Fixes: 3d725965f836 ("crypto: ccp - Add SEV_INIT_EX support")
> Reported-by: Peter Gonda <pgonda@google.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jacky Li <jackyli@google.com>

Acked-by: David Rientjes <rientjes@google.com>
