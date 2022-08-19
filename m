Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1472159A72E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 22:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350484AbiHSUqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiHSUq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C4CBD2A5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660941985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5cgYYhj6G+smkfpxIsmwhVxo5tlfOr/9RgCLQhOVfj4=;
        b=YIPKaMv1hd49PZ6Z3IlyTIKOGcoRFjEKTs8Y2sw97Jek//AVTXiPqb4pqo8X22aPAIAjt6
        Bd8FXrPZsq6KK5gpqXR1u7PWe0j1ayKucjr2RAMXg+Zn/2wWMrWA5zPrciVDx2xP0l9G7n
        Ro8OoRr6KzgWjTn41S+B3AlipJetmaE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-75-rDfcQIywNPCINsllK16Sbw-1; Fri, 19 Aug 2022 16:46:24 -0400
X-MC-Unique: rDfcQIywNPCINsllK16Sbw-1
Received: by mail-qk1-f200.google.com with SMTP id w22-20020a05620a445600b006bb7f43d1cfso4608123qkp.16
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=5cgYYhj6G+smkfpxIsmwhVxo5tlfOr/9RgCLQhOVfj4=;
        b=wqWBIIvHvu+rAvroVKm70WyR+xl6XstlljYalImJwfjdMJZsJP+tSpZlNBj87GqTxn
         8HRmS9nM6ypHGxUz0qMT8DIL3gW6ocleH83lkTXiz7YB3O2u188HZTpwW4ykfnA5i/W3
         Nf23IFnSjwcZ0V2QaS8OMMkja5XBypGtkQC5D7+ZodNTR8rNjpDk4sgniTQuJhGvBq2f
         PRrmMytTeIg1VqOR4DT+xVTnI4uKVbdTHTjUOrHuwk9nnKLoq9QdQysujHJIUV/D3M+a
         mdtVU9JbfJIdgmXY6NCz5JnpA6ogspJ773r4iduq8VtcRuDJz7Rm9bznYrItpvexVD86
         Tm7w==
X-Gm-Message-State: ACgBeo1zTgblgLZIPgJk8glHfTdEQmU5+udbrfPcPUhPCJhH4gkuwOp6
        BMx7wLMIfN9ZSUQa1c998m+KQEssxf/2jg774rVAx3RzfjHBtAuGswSPSmZ8j4tcqn2Cwa4ghV5
        SPKFF9pElPhgqVw25dSz3bncW
X-Received: by 2002:ae9:ed48:0:b0:6bb:cf35:853f with SMTP id c69-20020ae9ed48000000b006bbcf35853fmr4312679qkg.652.1660941983945;
        Fri, 19 Aug 2022 13:46:23 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4rIEk3pIFz32iO0wFU3kvAfmkyHxRH8Qg/MoQMHZGlvxMxaU2O0QtQfnHTfxJkLq6TdDcNcQ==
X-Received: by 2002:ae9:ed48:0:b0:6bb:cf35:853f with SMTP id c69-20020ae9ed48000000b006bbcf35853fmr4312667qkg.652.1660941983690;
        Fri, 19 Aug 2022 13:46:23 -0700 (PDT)
Received: from xps13 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id v21-20020a05620a441500b006bb20e8ee70sm4349730qkp.89.2022.08.19.13.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:46:23 -0700 (PDT)
Date:   Fri, 19 Aug 2022 16:46:22 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org
Subject: Re: [PATCH] regulator: core: Clean up on enable failure
Message-ID: <Yv/2niVMxT3Nrio+@xps13>
References: <20220819194336.382740-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819194336.382740-1-ahalaney@redhat.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 02:43:36PM -0500, Andrew Halaney wrote:
> If regulator_enable() fails, enable_count is incremented still.
> A consumer, assuming no matching regulator_disable() is necessary on
> failure, will then get this error message upon regulator_put()
> since enable_count is non-zero:
> 
>     [    1.277418] WARNING: CPU: 3 PID: 1 at drivers/regulator/core.c:2304 _regulator_put.part.0+0x168/0x170
> 
> The consumer could try to fix this in their driver by cleaning up on
> error from regulator_enable() (i.e. call regulator_disable()), but that
> results in the following since regulator_enable() failed and didn't
> increment user_count:
> 
>     [    1.258112] unbalanced disables for vreg_l17c
>     [    1.262606] WARNING: CPU: 4 PID: 1 at drivers/regulator/core.c:2899 _regulator_disable+0xd4/0x190
> 
> Fix this by decrementing enable_count upon failure to enable.
> 
> With this in place, just the reason for failure to enable is printed
> as expected and developers can focus on the root cause of their issue
> instead of thinking their usage of the regulator consumer api is
> incorrect. For example, in my case:
> 
>     [    1.240426] vreg_l17c: invalid input voltage found
> 
> Fixes: 5451781dadf8 ("regulator: core: Only count load for enabled consumers")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

