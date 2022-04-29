Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAD4515337
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 20:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379865AbiD2SGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 14:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiD2SGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 14:06:18 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0B68BE26;
        Fri, 29 Apr 2022 11:02:59 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l7so16901964ejn.2;
        Fri, 29 Apr 2022 11:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sBYSjhExy8FPS84fDKOS2lo0heZ+WhIcDHz+cn1FRbE=;
        b=irhsPAq3aUs20/CjP71rBBRTfgRKoLFdaziB2gz6m6KBvp6oXmY6NPO9sqMqMOELUf
         Xz2Dctb/hWVvAh2HbpS1VNe41kyo95D8EhzeUvw2HW5KAJwa2UApFLIIZFdi3YQ5o5NZ
         cJrFFee29SVr+AUrSPt0V4w0GMEX1VYL6BD/rgolwHmBnScwiYY0Mjtq27LADiAUyXno
         0AJg46DyvxJCDdYyK7V2iY5gvJkGcaZFTfHVBenuOnqsdAaDuO9+vjKyyqiHq7cBpFDc
         H5184lj/RquE0ScLPtj9CxuV0YmA+upDDRX2kqy3zj3tR3ER/HKk2idfm1wh8PfOsOPL
         I3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sBYSjhExy8FPS84fDKOS2lo0heZ+WhIcDHz+cn1FRbE=;
        b=qz+DK3xpy+Nl1Fy/s06qWtsp2q7jMttU84JBpUQuf0rQUKnIJ3TPkoTG0eXV/sf83d
         yk1PdghKf9wJcDCKb4mAkPaOv5S9sGUPZ614VZY7FLEnNdmguQeQ5Dz+vMd1TAKb89Yp
         rsX/99kRGzzK19Jd9o1niFTnMxzwnXO6UCaadHn+0L/MoRE17SH9HkJrIa/QmF2h+gQw
         MAPSRluAjh0UVbcYLZljWaepjcWcp+tANBsdeIFQKkB5QySyIIqZOO3z//cu0GMKMAjT
         IyogHvLbfSaT/siHXEXxNon4N/KLZvTkm1m0azQr0G7u0FvL+HOV/krfVF0zEzvlUqLT
         S/GA==
X-Gm-Message-State: AOAM530qEy3q6PmrggsucSUc1pn3VLJmZj9eL4+uXjBP1a6P/CggpwMM
        3rVgXrw1CR6XS1KlJa4TKJlWPyKN4g==
X-Google-Smtp-Source: ABdhPJzey0qcrgC+yH5euuaSkLBSbZ6GOQXju8Sfc9zdWKMENFdelOeNXZCmwn6FqtehVIY+ESWPJw==
X-Received: by 2002:a17:907:9482:b0:6da:8ad6:c8b5 with SMTP id dm2-20020a170907948200b006da8ad6c8b5mr496340ejc.372.1651255377899;
        Fri, 29 Apr 2022 11:02:57 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.99])
        by smtp.gmail.com with ESMTPSA id hf27-20020a1709072c5b00b006f3ef214e2fsm866785ejc.149.2022.04.29.11.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 11:02:57 -0700 (PDT)
Date:   Fri, 29 Apr 2022 21:02:55 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] ELF, uapi: fixup ELF_ST_TYPE definition
Message-ID: <YmwoT2/6rh6K1tDE@localhost.localdomain>
References: <Ymv7G1BeX4kt3obz@localhost.localdomain>
 <202204291019.B628991360@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202204291019.B628991360@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 10:25:23AM -0700, Kees Cook wrote:
> Please keep Eric & I CCed on ELF changes; there's a MAINTAINERS entry
> now...

Hah!

I honestly searched for 'ELF' before sending and didn't find anything.
