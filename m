Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4517D561A35
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 14:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbiF3MU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 08:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiF3MU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 08:20:56 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FF61FCE5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 05:20:55 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id v11-20020a4aa50b000000b00425a09bb69aso2526616ook.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 05:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JUW4jEINb79G6fZ0psu80KzN+ByrVZtzYVyL3ZG8d6c=;
        b=Fuqkt29l4izjw3eglRszJHoi91Vvjag/dTICHrTdpAVIpjz/jBKpFtnqUgrbsd87qt
         2uLLVSaDmUcSlPFrIdn9w+dQdI7ScgpWwIY8pLJq8DFrfqXoExYxe5UrHWnjIEhEMNNk
         7i03Et79pZitXulV8F5Tpyi4qAuaj2RFknak+BQ8X9mwVB/mGLiTc/J+qulYvIhtUpu/
         x+34rTHO5hpltf3dyDzzvi4liRJu2dCipyshYx5HUGIEELctPc+pYPgMfMIDoB8AgiJK
         +MUdlNlpHQ3x7td8GjJHPcHpwPnaj5m+OuWA18862gBHizX+oHX47HZpUfxUzyzB5nvH
         ZWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JUW4jEINb79G6fZ0psu80KzN+ByrVZtzYVyL3ZG8d6c=;
        b=SHR1RnOBcu8SvOUyr03Ie7/IAxLNukydAvUAMMqX4Yejl/kWrcPlBMjT20+aFHzftK
         1+QPBMZsVb0bjq14K2S0etmodaRL46mmyAwOL1iATcaCTdpmKXAg0e1atNiIGSnPHE7P
         tGFxvbX80nEHbC8WzoIxexwqPJuJxRXiB2DXxx7l/9fxM1kwzjiGikaJyZ0odD+/q2/1
         nlqGxoHA3X7+3m5BrOyBa8xKl1MbxphvDIA9foHIGlzB75jI5YIB1SCfohakQj1dF0Q/
         inVTo7Z/wY9XRhmrtvrbUyjcpDnosh/2V0Sixmcpl13NP2wAg0CPM4gK0GPRKSKUxsDe
         /MvQ==
X-Gm-Message-State: AJIora9hJ4wzC5WdTqMRUe3+iLSNYT17GvPEgHQ6LdMX+WQuEMK4PevS
        9W0sY+hMDDsZFPOvTlUEV/cAwCoArIyBFoEP337FAQ==
X-Google-Smtp-Source: AGRyM1ugYwGf8QObcJFeoodBaF0ml7JBvXxTHg+CSp32AI+BET/209D3TiHBTGz48E8bksakxkhoF2Jp9f0XG6nLU24=
X-Received: by 2002:a4a:e82b:0:b0:330:cee9:4a8a with SMTP id
 d11-20020a4ae82b000000b00330cee94a8amr3645347ood.31.1656591654007; Thu, 30
 Jun 2022 05:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220614204730.3359543-1-seanjc@google.com> <7e05e0befa13af05f1e5f0fd8658bc4e7bdf764f.camel@redhat.com>
 <CALMp9eQQROfYW7tNPaYCL5umjDr5ntsXuQ3BmorD8BWQiUGjdw@mail.gmail.com> <e04341912abfa1590edd4ee7c33efde6e227b93f.camel@redhat.com>
In-Reply-To: <e04341912abfa1590edd4ee7c33efde6e227b93f.camel@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 30 Jun 2022 05:20:43 -0700
Message-ID: <CALMp9eQ3EvQJFfyg2VW3Bb3-W9XGWnhtaS9zLPT4354yhroC2g@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] KVM: x86: Event/exception fixes and cleanups
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 1:24 AM Maxim Levitsky <mlevitsk@redhat.com> wrote:

> Neither can I access this document sadly :(
Try this one: https://docs.google.com/spreadsheets/d/1u6yjgj0Fshd31YKFJ524mwle7BhxB3yuEy9fhdSoh-0
