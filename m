Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E8B4DA50D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343614AbiCOWLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbiCOWLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:11:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B727731DE5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 15:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647382217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P/6a/mKTowgCRvBfrgs/YRVGEpshIsA2z9+KJS3pd3w=;
        b=XdK9QqRh5vgTM8FLwIYhv8F92eMJKuxppuVYemESSK0vljqoMl4C/0cTmQKq6e/CauCbQ3
        FSs9RBDf7+JxsYP7/5lI5sSVdO71LSLulkFvz3sV4ADhuMXxNohIGV7tpPfBUObl8HOW8Z
        nbtVqdT/U66ftwjVaZ94rCRH7WO3nfc=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-247-rxNL39-EMlOWjAN6cCXwHQ-1; Tue, 15 Mar 2022 18:10:16 -0400
X-MC-Unique: rxNL39-EMlOWjAN6cCXwHQ-1
Received: by mail-ot1-f71.google.com with SMTP id o6-20020a9d4106000000b005b23737b666so187597ote.16
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 15:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P/6a/mKTowgCRvBfrgs/YRVGEpshIsA2z9+KJS3pd3w=;
        b=NXdq3PMoC5W38syYEbZAhVy+UxIGqIf6UBeoe/L7X8Gzko9eOQRWOQffVFdhuzWtlY
         AsZvQP0m7et2jHXxoNUv2N4Y1aJfrzK07APtEsLPQiRL9y6Vmduq9hFmrXz1MA3FJR9f
         BMG8VOorthon8JU5yH0QSoyLYYsb7q8Poir68UrNrLibEAHhd0N4ZwX1ysZuqO565FaN
         KvPVVaiR6a02JiSyB7Ez8L8RP7ArxLzCH1RZZhFrKLT66228XHgbxihe8ltrpaanHMZW
         rkZD3geKZYltIQfKtcZMqCehameDOc3V0O3pRC8/SLBdf9hxfIDik1WKkF/1ZoQctcQ8
         1/yg==
X-Gm-Message-State: AOAM533ZauJs/ChaOvImv35ZqzivLA2ybl++dWiWGTU+hkRufdGlJz3s
        S0jyVN97k8VatjMhytS1bk3YGr48UEAVPXwn2stJJ4vJpC7lpWuuboTbUp4KKhjfneLpAd586fG
        /+lb8pu/iFT5+boC/1FKQ1qWz
X-Received: by 2002:a05:6870:41c7:b0:da:df9:2039 with SMTP id z7-20020a05687041c700b000da0df92039mr2305861oac.75.1647382215732;
        Tue, 15 Mar 2022 15:10:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtCYqhmglEUjSTOJUbxaFZTet3sxYMWypuVBA8zDjPqc0xhj2svC5cpitN0TQ0ycCPbVPeEQ==
X-Received: by 2002:a05:6870:41c7:b0:da:df9:2039 with SMTP id z7-20020a05687041c700b000da0df92039mr2305851oac.75.1647382215508;
        Tue, 15 Mar 2022 15:10:15 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::48])
        by smtp.gmail.com with ESMTPSA id ay44-20020a056808302c00b002d9d2b564absm185471oib.43.2022.03.15.15.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 15:10:14 -0700 (PDT)
Date:   Tue, 15 Mar 2022 15:10:11 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v1 1/2] static_call: Properly initialise
 DEFINE_STATIC_CALL_RET0()
Message-ID: <20220315221011.aeh67zvgproc4zvq@treble>
References: <1e0a61a88f52a460f62a58ffc2a5f847d1f7d9d8.1647253456.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1e0a61a88f52a460f62a58ffc2a5f847d1f7d9d8.1647253456.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 11:27:35AM +0100, Christophe Leroy wrote:
>  #define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)	__PPC_SCT(name, "b " #func)
>  #define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)	__PPC_SCT(name, "blr")
> +#define ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)	__PPC_SCT(name, "b .+20")

There's a PPC_SCT_RET0 macro for this "20" offset, might as well use a
stringified version of that for robustness/readability.

Otherwise it looks reasonable.

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

