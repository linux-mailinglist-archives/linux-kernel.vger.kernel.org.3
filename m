Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B5256C1DE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240072AbiGHUWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240061AbiGHUWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:22:18 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF35488F0A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:22:16 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id a12so8358048ilp.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 13:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/UZePUHRNJILM679cWPNfgYLf9iBJLiMq5x1kWJ7CZ4=;
        b=U4pdhs9bqBwM/E03LS2JpiFDCzjMlIq4GhGcpD6IuJj8LLGxXDbSJwvnx+GS0OJdVB
         Fk3e8R/0Mo4Hti7k2MR7W66WaMnhWkydN3kRYJ2NNjthsCuxlV8LPe1zcEz/GEs4F1ZW
         NoMF3cvZe2cnKZriRCjzI1C2hZQSt7+5L0pT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/UZePUHRNJILM679cWPNfgYLf9iBJLiMq5x1kWJ7CZ4=;
        b=HCjcN0SKTtEY5Z81pCGXBTIWrTYt2TxFuraahhNhHMsG5/lIGKkgwLhxFQai4LhNvF
         DSop+YJQ3wndfyqxYDgVUwVtL9Fo1WCPOsiS6Cv4VadrAhXH+7AoAUlMaKMh4DRKSCG2
         Tg1ryYvNV4a9vPHHbzSB8oRtQhZe2TEOnNNLUxAsf08IVyfrboJ+MP2NMTPd6jITh6fd
         wwlLUG25eakwACgoe2GW5CqmiawMbomQeSMEGJ5NVd6OVpvY2I/nRoWRQCqx8LQzPz4R
         hO2aNSv2BF2iyGN4MSqhAWo1mvJccIO1Yf1BSg5sA9HfeRVoNoljeudAsab04GXy4nOG
         G/IQ==
X-Gm-Message-State: AJIora+mIff+Jd08V35bSAeCEawoRlLDIY3Wu6V4sbSno2/sdbL+inqx
        62H6nvyTMRR1E9wVrNhfGkPWkA==
X-Google-Smtp-Source: AGRyM1sqoFVBarg/sjA1rALOnA1pW658MEpnpIO3S4XvRk/cZWsGRtqSyVTChGm4FvqKvvqsH5qgAg==
X-Received: by 2002:a05:6e02:144f:b0:2dc:2850:2956 with SMTP id p15-20020a056e02144f00b002dc28502956mr3093263ilo.258.1657311736099;
        Fri, 08 Jul 2022 13:22:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id u18-20020a92ccd2000000b002d8d813892csm16967320ilq.8.2022.07.08.13.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 13:22:15 -0700 (PDT)
Subject: Re: [PATCH v6 3/4] kunit: Taint the kernel when KUnit tests are run
To:     David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kbuild@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220708044847.531566-1-davidgow@google.com>
 <20220708044847.531566-3-davidgow@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <fc638852-ac9a-abab-8fdb-01b685cdec96@linuxfoundation.org>
Date:   Fri, 8 Jul 2022 14:22:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220708044847.531566-3-davidgow@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/22 10:48 PM, David Gow wrote:
> Make KUnit trigger the new TAINT_TEST taint when any KUnit test is run.
> Due to KUnit tests not being intended to run on production systems, and
> potentially causing problems (or security issues like leaking kernel
> addresses), the kernel's state should not be considered safe for
> production use after KUnit tests are run.
> 
> This both marks KUnit modules as test modules using MODULE_INFO() and
> manually taints the kernel when tests are run (which catches builtin
> tests).
> 
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> Tested-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> 
> No changes since v5:
> https://lore.kernel.org/linux-kselftest/20220702040959.3232874-3-davidgow@google.com/
> 
> No changes since v4:
> https://lore.kernel.org/linux-kselftest/20220701084744.3002019-3-davidgow@google.com/
> 

David, Brendan, Andrew,

Just confirming the status of these patches. I applied v4 1/3 and v4 3/4
to linux-kselftest kunit for 5.20-rc1.

I am seeing v5 and v6 now. Andrew applied v5 looks like. Would you like
me to drop the two I applied? Do we have to refresh with v6?

thanks,
-- Shuah

