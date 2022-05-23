Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEBB531610
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiEWTMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiEWTL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:11:58 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FB9127184;
        Mon, 23 May 2022 11:47:06 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id oe17-20020a17090b395100b001df77d29587so79466pjb.2;
        Mon, 23 May 2022 11:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=76y2+oo/qoXjDueiDl15GinWPP3MWuyZztlDDTW4C/M=;
        b=F4PlRYXJF2/GFGMk4w6a7AxUnjicJVCwRusnWkr1inPCRqBzTVedrz5vRAOFJzoHU7
         WNRAVJ8aU3StNlBBA3b4ER8ntGB0aBFL9Kng1oJxAse4h4Yl5agPyt0t3j8UEM0wE6Hf
         9XlQt43WSUJvxGNloCUAmPn+Db2vQZAAY2YDHth1oEtIOL89N0SVMLf8J8wuhssKiWMF
         TxpWsZ09eE3Rxi2t+EALL/qFpYR/Fjawm6KlFGFOyWXw4HInsaW/3TjoS0iViCALkb6/
         Mh467VsaT2bJT0ids++DspMVGP3tzlVkXrs7unHw81dDb5+bHjQR20T08WC8/OQGZdGE
         K2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=76y2+oo/qoXjDueiDl15GinWPP3MWuyZztlDDTW4C/M=;
        b=yWS2PDZ4no+eHNnxdXGgeX3xWcDoDubp9ez1NoMQU8Z9Ns0e5w/Iu12eWxzDOi29ux
         SZWaXrcqiCkD8KWQTFCT0SBM68+wfm/AHdtPGy1NbwOx/rhweBbGFVzA8BVHgtCEqJOa
         TGTRJMrogUfpQEKla7DvfdFVLNpD+65YZWTI4oIcj8xT9N+goaGOjJ2WWTdshu0BisE/
         7RKN2ZkN2zQU6IdKFgMHiUaXF6p1VUy5oIdd/5y8I7M6huj53HL3SZXtyOZBywb5j5jK
         +YU/XtWLAp5hkgsZaOGQKRPGAkMUO74kxfUF+oz/wUHLKw8qyNu10gb4OReIsb+Qx/l8
         rA7A==
X-Gm-Message-State: AOAM533g97ygDo+edrS19Xz62WHUYu+8t+yPhQ8vCFb7x2CwWmWMaRan
        5demWMg+GwK3E4+YnJhivMg=
X-Google-Smtp-Source: ABdhPJya/XVPBAZBJWCeJgtfcR/OthObwsxduUh9+jPxAPH/otv1kUfC0sA+9tHxzhgCAjUQbVSr6g==
X-Received: by 2002:a17:90b:4b0a:b0:1df:deda:7880 with SMTP id lx10-20020a17090b4b0a00b001dfdeda7880mr372129pjb.53.1653331625696;
        Mon, 23 May 2022 11:47:05 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:ce25:f34f:c90d:61fa])
        by smtp.gmail.com with ESMTPSA id y132-20020a62ce8a000000b00518285976cdsm7519431pfg.9.2022.05.23.11.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 11:47:04 -0700 (PDT)
Date:   Mon, 23 May 2022 11:47:01 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: matrix-keymap: Add common
 'linux,no-autorepeat' property
Message-ID: <YovWpSvabyhcYnzL@google.com>
References: <20220523170449.1763039-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523170449.1763039-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 12:04:49PM -0500, Rob Herring wrote:
> 'linux,no-autorepeat' is a common property used in multiple bindings,
> but doesn't have a common type definition nor description. Add a common
> definition and drop the now redundant description from
> holtek,ht16k33.yaml.

We have "autorepeat" in the common input binding description, should we
not promote it over "no-autorepeat"?

Thanks.

-- 
Dmitry
