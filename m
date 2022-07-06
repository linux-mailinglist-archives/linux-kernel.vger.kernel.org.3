Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AFF56912C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbiGFRzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbiGFRzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:55:00 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2650E1EAEF;
        Wed,  6 Jul 2022 10:54:59 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id q6so28336221eji.13;
        Wed, 06 Jul 2022 10:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qbdxu/r+jCtprx8y/eB9RZZ/+03c5P/jQcHzM+z9Q3w=;
        b=d/NAI1EjqB5PbR3gVTEyyB3dfjlZp8U7bXJYoPp9BSOLBhU2i6lSbv+53FJ+n6KL9d
         soK+lsnyXFFXtKMd6aME6AHi/AvQY5DtMIJoJHOjRZkEjaQGZigClBsxYlpn04vlrY44
         dtQKjtNVNXZAIbThN54J8khlCR7Onf6R7QF/I0ix2IGgrJE3FQaJlFMDYGsFXRGNoI5B
         5Eg186mlY3HZ55FYe9vTvLOlpWYSVjUqo3TCRnR7xmsMq8f7vN3nvktNtorsXRHT8hiE
         HzEy8ZFJrTRgIogw2cUzbGyRTP4WH9WmqANbRBmBFjnEsZz8bdzq5D3qYAi0bAOijyAk
         dQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qbdxu/r+jCtprx8y/eB9RZZ/+03c5P/jQcHzM+z9Q3w=;
        b=iGu1L+dwG47n8CW/z5LQmky00VVwvwyWU2QQbVNT1LxV/hchcLLP3RDhrmNC9FtOmI
         E+5d9xR5HjrZduHHvPrdFafFU/Mp5+jxbk+UZd4Wh8416RTe0RMscSkPgVfYUafs41Ek
         8celSEWMfhscVHfz8+r0HtQAnQh7t4mM/dPuOrd4g1e7ytq6qil5OHAXNOy43pUpGHtb
         hHoBrQR6LkNNr7FhSsIqbdlRNS+YkYfpMeFIG8Qjk1W/qn5l3434YfHpZlkOu1K+UJ+0
         6csXNwwSC0fY+2EXGHbt0M3yVqyjA/cxZruyrcpjhTtVAzTIrhIf9REVJculCYiO2bnk
         +YcA==
X-Gm-Message-State: AJIora/ppx4aUDrzU5L4/UvfWP1SgOeH53ZzQL8rLfwvk9Y6iVDYjqIl
        6FASLRVe9t29bOH2HxiF1IAhVTFfN2vuPHuA
X-Google-Smtp-Source: AGRyM1vIUnYU5r76EM3EPTKZfb0wibZslvgaySFroVYk0s+EqwXsW+wnasLjpCQco16WB93I5YgZZA==
X-Received: by 2002:a17:907:2bdc:b0:72a:47b5:dbff with SMTP id gv28-20020a1709072bdc00b0072a47b5dbffmr38671760ejc.677.1657130097418;
        Wed, 06 Jul 2022 10:54:57 -0700 (PDT)
Received: from reki (87-168-253.netrunf.cytanet.com.cy. [87.228.168.253])
        by smtp.gmail.com with ESMTPSA id kz11-20020a17090777cb00b0072af18329c4sm1845297ejc.225.2022.07.06.10.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 10:54:56 -0700 (PDT)
Date:   Wed, 6 Jul 2022 20:54:54 +0300
From:   Maxim Devaev <mdevaev@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     stern@rowland.harvard.edu, balbi@kernel.org,
        gregkh@linuxfoundation.org, caihuoqing@baidu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_mass_storage: forced_eject attribute
Message-ID: <20220706205454.2f4483d0@reki>
In-Reply-To: <20220706174634.20639-1-mdevaev@gmail.com>
References: <20220706174634.20639-1-mdevaev@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=92 Wed,  6 Jul 2022 20:46:34 +0300
Maxim Devaev <mdevaev@gmail.com> wrote:

> The patch is a completely alternative implementation of the previously
> proposed [1], the idea of which was born after the mentioned discussion.
> Link: https://lore.kernel.org/lkml/20220406092445.215288-1-mdevaev@gmail.=
com [1]

A small comment after that, which is not worth mentioning in the body of th=
e patch.
As discussed in the previous thread, I made a clean implementation to reset
the prevent_medium_removal flag instead of using SIGUSR1, tested it myself,
and then on several thousand of my users. I haven't received a single compl=
aint
in a few months, so I guess everything is working as intended.
