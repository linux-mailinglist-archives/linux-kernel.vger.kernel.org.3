Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC384DA462
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 22:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351890AbiCOVNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 17:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351875AbiCOVNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:13:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8791574A5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 14:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647378724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eAf5AEBeFqncM2mZPk7z8DJiDJfh3mMRBEhEpcF9DSI=;
        b=Yy2pzt00T493hK7RN+PmO7IYNO77Kk/eZHMabri/yCN9J2KrG+pLoPqKrkwRJWkCIKSkdy
        dAZ4EoSXU40908IlDckfXsK8MUWC5to0kxQ39f95Svtead/R6OH0LUXi4k02raSFSPHMXY
        yFFahHCVG1ooid0CBLYq69+v310VVbU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-YPWGjkovOQW47EaPBwGBTg-1; Tue, 15 Mar 2022 17:12:02 -0400
X-MC-Unique: YPWGjkovOQW47EaPBwGBTg-1
Received: by mail-qv1-f71.google.com with SMTP id g2-20020a0562141cc200b004123b0abe18so434275qvd.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 14:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eAf5AEBeFqncM2mZPk7z8DJiDJfh3mMRBEhEpcF9DSI=;
        b=u3awg3LfZy57w9eszVsWEzW/u9/CCJhg8e4bnNSXWWcLeHmky4n5YM/+FnT3uw/Z78
         pvvYcvXGEv5awbPMaUVsV/FulXlHmeOVKSf+GgRpWn0jcvLePideRI+AM/H40v8AdSCr
         MB15LQI4jbPatWqxBuUTDRGLdSZWeeiR4xW0hWjPGmyzrDPNPIAgMB6+sHs2qmseZbAB
         bfoKC4IRA/wVZD1kJdPWPZ5CSQPegQAwuhBTHtQS7b6yfjmd8UdDGOOBOhcqBLY3pvmn
         sOeynZOhSkJriwsLkg7Sn2k6FbhtxhD9knCi4JDdooeEGegRaWQyweu1VqNjK7fGKC7E
         QIfg==
X-Gm-Message-State: AOAM530fBrLKHEL1DaNEMzHNqUgfhZnBC6rdUg/lKBinGWYiKSnZHAki
        ziVGLcXW4OXFXzyX7ueHXi9xNbRgYzAVGIzWm9CZoNaHcrTDtinFl3iuy/vMDeplV0EIykK7si6
        FN4VJvGDI4yLDfNPv+uM/gC/r
X-Received: by 2002:ac8:7f86:0:b0:2e1:b6b3:2ca4 with SMTP id z6-20020ac87f86000000b002e1b6b32ca4mr20712867qtj.127.1647378722276;
        Tue, 15 Mar 2022 14:12:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3tiPn9/YdA516P6OSNiW8pKYq75gkw7DPVujILQFkg1ot6rPcBGlIsHytrLXTxkev21udzg==
X-Received: by 2002:ac8:7f86:0:b0:2e1:b6b3:2ca4 with SMTP id z6-20020ac87f86000000b002e1b6b32ca4mr20712854qtj.127.1647378722001;
        Tue, 15 Mar 2022 14:12:02 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::48])
        by smtp.gmail.com with ESMTPSA id z6-20020ae9c106000000b0067d3b9ef387sm18807qki.28.2022.03.15.14.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 14:12:01 -0700 (PDT)
Date:   Tue, 15 Mar 2022 14:11:58 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH] static_call: Don't make __static_call_return0 static
Message-ID: <20220315211158.kymtyh2nv4xj7ite@treble>
References: <b301796066e4fdd45c50c9e202d36a43688eb78e.1647242388.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b301796066e4fdd45c50c9e202d36a43688eb78e.1647242388.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 08:21:30AM +0100, Christophe Leroy wrote:
> System.map shows that vmlinux contains several instances of
> __static_call_return0():
> 
> 	c0004fc0 t __static_call_return0
> 	c0011518 t __static_call_return0
> 	c00d8160 t __static_call_return0
> 
> arch_static_call_transform() uses the middle one to check whether we are
> setting a call to __static_call_return0 or not:
> 
> 	c0011520 <arch_static_call_transform>:
> 	c0011520:       3d 20 c0 01     lis     r9,-16383	<== r9 =  0xc001 << 16
> 	c0011524:       39 29 15 18     addi    r9,r9,5400	<== r9 += 0x1518
> 	c0011528:       7c 05 48 00     cmpw    r5,r9		<== r9 has value 0xc0011518 here
> 
> So if static_call_update() is called with one of the other instances of
> __static_call_return0(), arch_static_call_transform() won't recognise it.
> 
> In order to work properly, global single instance of __static_call_return0() is required.
> 
> Fixes: 3f2a8fc4b15d ("static_call/x86: Add __static_call_return0()")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

