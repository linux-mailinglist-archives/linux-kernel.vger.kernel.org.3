Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B707C5817E9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239584AbiGZQui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 12:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239577AbiGZQug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:50:36 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC5027FD1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 09:50:35 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-31bf3656517so148993107b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yatLlbPycdFw8wIENuYy6U5zb3pxVwzEiJQ0zzMa1qs=;
        b=MBiWps94nweIVeUVjHCgTBxfJF7VluRqwUFUVKge1oip9SKL59IkTVcTgIf/Z9Fdwm
         ZdA5FKGri1nX2C6TE+jIfmvkIQ5Umfnd6PAeRva8PJJT9p9ZfoiZds+/6NTzNRjvL8Hx
         GKx3upNhgMQM01nB3q0yOrnUAigkcLXqqPGMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yatLlbPycdFw8wIENuYy6U5zb3pxVwzEiJQ0zzMa1qs=;
        b=g23nXRLxQumM6S3sWPtvnx8PXd6HOV/zw4x8Ne12ox+5oe+fO72ryDQ+rCo6P6z210
         yf7uYrbk94KKFPqNJuXQokMQCYEkGx9Df82hFV0BEK/T8yDPxeTd2Jjx+/svNgqmu7V7
         7wdiMFRKjrrvKXxnKEe2Mh6kgOkMSKc+Uh/03jvkSPfOj62RXi9K+sLF8q/sQZCbJ3hZ
         aZjOqiFUZ+d9ZHbmPNbzoYW905p3lM0Y1xQrBwo3yS6UHqnGpU+9krN5vGJyakuDU3DW
         wMbGDOZiRVqMhrKEHBXBTEYxfvYF1eC3FdB1Z9N0vQ16NTIC52XTOy+Zk9LiQ7cbbvK9
         ImJg==
X-Gm-Message-State: AJIora/0c3+RWUzCbzeZE90raRYy8AxSgtKJuLKibDafrZKlURayi/V5
        IKa0CzrbaLMp4UH1KwzWw6tc/snjmb0U/e/zFiM+U4h8tcQ=
X-Google-Smtp-Source: AGRyM1t7suzX+rz1oK3VML0GR3OYvKlC9WC9Elf1CugCpf7ht1Ys0bfMjnh7FYyNnaIAZ68LuFclxhKQV7yiRR/eKis=
X-Received: by 2002:a0d:c787:0:b0:31b:a963:e1de with SMTP id
 j129-20020a0dc787000000b0031ba963e1demr15027224ywd.283.1658854234250; Tue, 26
 Jul 2022 09:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220725203129.1973260-1-nfraprado@collabora.com>
In-Reply-To: <20220725203129.1973260-1-nfraprado@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 26 Jul 2022 09:50:24 -0700
Message-ID: <CACeCKaeN12pikzZOVHSv-JQJn4z7Cn61wTqoiAce58-QRSqk_g@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: retimer: Add missing id check in match callback
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI N=C3=ADcolas,

On Mon, Jul 25, 2022 at 1:31 PM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> The fwnode_connection_find_match() function handles two cases: named
> references and graph endpoints. In the second case, the match function
> passed in is called with the id to check for the match. However, the
> match function for the recently added type-c retimer class assumes the
> connection has already been matched (which is only true for the first
> case).
>
> The result is that with that change, all type-c nodes with graph
> endpoints defer probe indefinitely, independently of having a retimer
> connection or not.
>
> Add the missing check, like is done by the type-c mux and usb role
> switch code, to fix the issue.
>
> Fixes: ddaf8d96f93b ("usb: typec: Add support for retimers")
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
FWIW,
Reviewed-by: Prashant Malani <pmalani@chromium.org>
