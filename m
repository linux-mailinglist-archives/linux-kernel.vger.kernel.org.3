Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EAC580127
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 17:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbiGYPIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 11:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbiGYPH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 11:07:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFD4912D0D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 08:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658761674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+wMWEjIDNNqnLmFB9jSByNuvGb3F+pRglsUFoI477rs=;
        b=ay38YxybujBPwzgFf96ERxw6SGf2PexhvS/RywoaNT2jpePGcCn9hh5AtDXW0Y/K0YrFyW
        dDsEZ95CLG1qQ34ON1FluxZDtwSyySEUup6BfUuFw8dm8KhFbDAhQHDc+RH7gaeYIo56tQ
        2Ykgc3UnWonr32YDkr3O+fmASGnML0M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-1gDUrYxJMseYgSJeSR52MQ-1; Mon, 25 Jul 2022 11:07:50 -0400
X-MC-Unique: 1gDUrYxJMseYgSJeSR52MQ-1
Received: by mail-wm1-f72.google.com with SMTP id r82-20020a1c4455000000b003a300020352so6294674wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 08:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+wMWEjIDNNqnLmFB9jSByNuvGb3F+pRglsUFoI477rs=;
        b=5XNLwzrgATW8Po7fUoismhu5KBOXf5Kwl9c9fo+2ZyXE3tLeQ6SVhBRkz2OswfAtSm
         8lFBUZ+Hz1ReBHvhPNaL2/yigGMyQv7ocIhKonzQGTdPAp8LwwJrCP74c8LnWdYs9W6r
         m3LoN/MUTYUlCzmpUpVhGXLsdhbE5I0GGi+vVOV5tMyb5CSrZcC05jisRCMq8MhOfsut
         kCLp+JEfwR86kW3mb4Gx5ALz8j+EKXOXePhVcYoLzEt8qyeaWcKvlxIqmhms949Y0oIN
         ehOUkheEj/shQ+91aO7eGZTX/ePE/8tP1GilxdW+g3qYFKEUvaJiaxt1SGzL2A345cbz
         22dA==
X-Gm-Message-State: AJIora+YMfTorQC1PB69MaSCfV251GNzb3XFeXi+6DFKn6AblZ8nZXEG
        0Jj5btI/3SmYvKuX0+W5MHVedmkET/HEuZNPNT5KlRpvSbRAYtQyh8kJb9Y2SaZ2Sel8ETYJ3UF
        CLoRyr1ga1L7X6boW+25OHtPp
X-Received: by 2002:a05:6000:2a4:b0:21e:6e0e:df1f with SMTP id l4-20020a05600002a400b0021e6e0edf1fmr7691164wry.516.1658761669174;
        Mon, 25 Jul 2022 08:07:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uBREo/HmCfN0EvHadqQhcrXwpmXEWo8PDdUj0o68FX9PWiVcBtViLzd/eGUecKeRtuylh3lw==
X-Received: by 2002:a05:6000:2a4:b0:21e:6e0e:df1f with SMTP id l4-20020a05600002a400b0021e6e0edf1fmr7691155wry.516.1658761668985;
        Mon, 25 Jul 2022 08:07:48 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id i13-20020a05600011cd00b0021d6924b777sm11980970wrx.115.2022.07.25.08.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:07:48 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Vincent Donnefort <vdonnefort@google.com>, peterz@infradead.org,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>,
        Derek Dolney <z23@posteo.net>
Subject: Re: [PATCH v5] cpu/hotplug: Do not bail-out in DYING/STARTING sections
In-Reply-To: <20220725095952.206884-1-vdonnefort@google.com>
References: <20220725095952.206884-1-vdonnefort@google.com>
Date:   Mon, 25 Jul 2022 16:07:47 +0100
Message-ID: <xhsmh1qu9fcxo.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/22 10:59, Vincent Donnefort wrote:
> The DYING/STARTING callbacks are not expected to fail. However, as reported
> by Derek, drivers such as tboot are still free to return errors within
> those sections, which halts the hot(un)plug and leaves the CPU in an
> unrecoverable state.
>
> No rollback being possible there, let's only log the failures and proceed
> with the following steps. This restores the hotplug behaviour prior to
> commit 453e41085183 ("cpu/hotplug: Add cpuhp_invoke_callback_range()")
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215867
> Fixes: 453e41085183 ("cpu/hotplug: Add cpuhp_invoke_callback_range()")
> Reported-by: Derek Dolney <z23@posteo.net>
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> Tested-by: Derek Dolney <z23@posteo.net>
>

The changelog has some undesired stowaways below, but regardless:
Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> v4 -> v5:
>    - Remove WARN, only log broken states with pr_warn.
> v3 -> v4:
>    - Sorry ... wrong commit description style ...
> v2 -> v3:
>    - Tested-by tag.
>    - Refine commit description.
>    - Bugzilla link.
> v1 -> v2:
>    - Commit message rewording.
>    - More details in the warnings.
>    - Some variable renaming
>

